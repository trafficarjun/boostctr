class SearchConsole::SavePageKeywordWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id, row)
    impression_limit = 100
    position_limit = 10
    ctr = (row["ctr"] * 100).round(2)
    #round position to upper
    position = row["position"].round()
    clicks = row["clicks"]
    impressions = row["impressions"]
    shop = Shop.find_by id: shop_id
    old_page = shop.pages.find_by url: row["keys"].first if shop
    #add keywords only if impressions greater than 100 and position less than 10
    if !Rails.env.production?
      impression_limit = 0
      position_limit = 1000
    end
    if shop && (impressions > impression_limit) && (position.to_i <= position_limit) 
      #save page
      if shop
        page = old_page 
        page = Page.create(shop_id: shop.id, url: row["keys"].first) if !page
      end
      
      #if keyword includes branded mention that in the stat
      if (row["keys"].second.include? shop.brand_name) || (row["keys"].second.include? shop.brand_name.downcase) || (row["keys"].second.include? shop.brand_name.upcase)
        includes_brand_name = true
      else
        capital = shop.brand_name.split.map(&:capitalize).join(' ')
        if row["keys"].second.include? capital
          includes_brand_name = true
        else
          includes_brand_name = false
        end
      end
      
      keyword_count = row["keys"].second.split.size
      keyword_count = 4 if keyword_count > 4
      
      #saving keyword and keyword stats for showing branded and non branded graphs.
      if shop
        keyword = shop.keywords.find_by name: row["keys"].second 
        if !keyword
          keyword = Keyword.create(shop_id: shop.id, name: row["keys"].second, includes_brand_name: includes_brand_name, keyword_count: keyword_count) 
          #create a new keyword stat
          keywordstat = Stat.create(shop_id: shop.id, clicks: clicks, impressions: impressions, ctr: ctr, position: position)
          KeywordStat.create(keyword_id: keyword.id, stat_id: keywordstat.id) if keywordstat
        else
          #update old keyword stat with this new clicks, impressions and ctr
          #get the old_stat at this position
          old_keyword_stat_at_position = keyword.stats.find_by position: position      
          if old_keyword_stat_at_position
            #calculate CTR for this keyword at the current Rank
            #CTR formula is sum of clicks / sum of impressions
            new_clicks = clicks.to_i + old_keyword_stat_at_position.clicks.to_i
            new_impressions = impressions.to_i + old_keyword_stat_at_position.impressions.to_i
            new_ctr = (new_clicks.to_f / new_impressions.to_f).round(2) * 100
            #update old stat at this position for this page
            old_keyword_stat_at_position.update(clicks: new_clicks, impressions: new_impressions, ctr: new_ctr)
          else
            #create new page stat at this position
            new_keyword_stat = Stat.create(shop_id: shop.id, clicks: clicks, impressions: impressions, ctr: ctr, position: position)
            KeywordStat.create(keyword_id: keyword.id, stat_id: new_keyword_stat.id) if new_keyword_stat
          end
        end
      end
      
      if page && keyword
        page_keyword = page.page_keywords.find_by(keyword_id: keyword.id) 
        page_keyword = PageKeyword.create(page_id: page.id, shop_id: shop.id, keyword_id: keyword.id) if !page_keyword
      end
      
      old_page_keyword_stat_at_position = page_keyword.stats.find_by position: position    
      if old_page_keyword_stat_at_position
        old_page_keyword_stat_at_position.update(clicks: clicks, impressions: impressions, ctr: ctr, position: position)
      else
        #create a page keyword stat
        statcreated = Stat.create(shop_id: shop.id, clicks: clicks, impressions: impressions, ctr: ctr, position: position) if page_keyword
        PageKeywordStat.create(page_keyword_id: page_keyword.id, stat_id: statcreated.id) if statcreated
      end
      
      #save that as the page stat only if stat is coming from non branded keyword - I am adding the branded keyword stat to keywords under shops - but not making it influence the page stats as page stats ctr is caluclated from non branded keywords.
      if page && includes_brand_name == false
        #if there is page stat
        if page.stats.any? 
          #get the old_stat at this position       
          old_page_stat_at_position = page.stats.find_by position: position
          if old_page_stat_at_position
            #calculate CTR for this page at the current Rank
            #CTR formula is sum of clicks / sum of impressions
            new_clicks = clicks.to_i + old_page_stat_at_position.clicks.to_i
            new_impressions = impressions.to_i + old_page_stat_at_position.impressions.to_i
            new_ctr = (new_clicks.to_f / new_impressions.to_f).round(2) * 100
            #update old stat at this position for this page
            old_page_stat_at_position.update(clicks: new_clicks, impressions: new_impressions, ctr: new_ctr)
          else
            #create new page stat at this position
            new_stat = Stat.create(shop_id: shop.id, clicks: clicks, impressions: impressions, ctr: ctr, position: position)
            PageStat.create(page_id: page.id, stat_id: new_stat.id) if new_stat
          end
        else
          #if no page stat save the keyword stat is this pages first stat.
          new_stat = Stat.create(shop_id: shop.id, clicks: clicks, impressions: impressions, ctr: ctr, position: position)
          PageStat.create(page_id: page.id, stat_id: new_stat.id) if new_stat
        end
      end
      
      if page && !old_page
        shopify_session = ShopifyAPI::Session.new(domain: shop.shopify_domain, token: shop.shopify_token, api_version: '2019-10')
        ShopifyAPI::Base.activate_session(shopify_session)
        if page.shopify_page_type == "products"
          shopify = ShopifyAPI::Product.find(:all)
          shopify_page = shopify.select { |attribute| attribute.handle == page.handle}.first
          if shopify_page != nil
            #instead of updating shopify id - where it may fail if page is used elsewhere - I create new shopify
            page.store.destroy if page.store
            Store.create(page_id: page.id, shopify_id: shopify_page.id)
          end
        elsif page.shopify_page_type == "pages"
          shopify = ShopifyAPI::Page.find(:all)
          shopify_page = shopify.select { |attribute| attribute.handle == page.handle}.first
          if shopify_page != nil
            page.store.destroy if page.store
            Store.create(page_id: page.id, shopify_id: shopify_page.id)
          end
        elsif page.shopify_page_type == "blogs"
          shopify = ShopifyAPI::Article.find(:all)
          shopify_page = shopify.select { |attribute| attribute.handle == page.handle}.first
          if shopify_page != nil
            page.store.destroy if page.store
            Store.create(page_id: page.id, shopify_id: shopify_page.id)
          else
            shopify = ShopifyAPI::Blog.find(:all)
            shopify_page = shopify.select { |attribute| attribute.handle == page.handle}.first
            if shopify_page != nil
              page.store.destroy if page.store
              Store.create(page_id: page.id, shopify_id: shopify_page.id)
            end
          end
        elsif page.shopify_page_type == "collections"
          shopify = ShopifyAPI::CustomCollection.find(:all)
          shopify_page = shopify.select { |attribute| attribute.handle == page.handle}.first
          if shopify_page != nil
            page.store.destroy if page.store
            Store.create(page_id: page.id, shopify_id: shopify_page.id)
          else
            shopify = ShopifyAPI::SmartCollection.find(:all)
            shopify_page = shopify.select { |attribute| attribute.handle == page.handle}.first
            if shopify_page != nil
              page.store.destroy if page.store
              Store.create(page_id: page.id, shopify_id: shopify_page.id)
            end
          end
        elsif page.shopify_page_type == "frontpage"
          shopify = ShopifyAPI::Page.find(:all)
          shopify_page = shopify.select { |attribute| attribute.handle == page.handle}.first
          if shopify_page != nil
            page.store.destroy if page.store
            Store.create(page_id: page.id, shopify_id: shopify_page.id)
          end
        end
      end
      

    end
  end
end