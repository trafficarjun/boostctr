class Shops::Pages::TestsController < ApplicationController
  def new
    @shop = Shop.find_by slug: params[:shop_id]
    @page = @shop.pages.find_by slug: params[:page_id]
    @tests = @page.tests
    @test = @page.tests.new
    
    @starting_date = Time.current + 3.days
    @ending_date = Time.current + 33.days
    @one_week_before_starting_date = Time.current - 7.days
    @one_week_before_ending_date = Time.current - 1.days
    @two_week_before_starting_date = Time.current - 14.days
    @two_week_before_ending_date = Time.current - 1.days
    @four_week_before_starting_date = Time.current - 30.days
    @four_week_before_ending_date = Time.current - 1.days
    @one_week_after_starting_date = Time.current + 3.days
    @one_week_after_ending_date = Time.current + 10.days
    @two_week_after_starting_date = Time.current + 3.days
    @two_week_after_ending_date = Time.current + 17.days
    @four_week_after_starting_date = Time.current + 3.days
    @four_week_after_ending_date = Time.current + 33.days
    shopify_session = ShopifyAPI::Session.new(domain: @shop.shopify_domain, token: @shop.shopify_token, api_version: '2019-10')
    ShopifyAPI::Base.activate_session(shopify_session)
    if @page.store
      if @page.shopify_page_type == "products"
        begin 
          @shopify_page = ShopifyAPI::Product.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
        end
      elsif @page.shopify_page_type == "pages"
        begin 
          @shopify_page = ShopifyAPI::Page.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
        end
      elsif @page.shopify_page_type == "blogs"
        begin 
          @shopify_page = ShopifyAPI::Article.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
          begin 
            @shopify_page = ShopifyAPI::Blog.find(@page.store.shopify_id)
          rescue ActiveResource::ResourceNotFound
            nil
          end
        end
      elsif @page.shopify_page_type == "collections"
        begin 
          @shopify_page = ShopifyAPI::CustomCollection.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
          begin 
            @shopify_page = ShopifyAPI::SmartCollection.find(@page.store.shopify_id)
          rescue ActiveResource::ResourceNotFound
            nil
          end
        end
      end
    end
    if @shopify_page != nil
      if @shopify_page.metafields.any?
        @title = @shopify_page.metafields.select { |attribute| attribute.namespace == 'global' && attribute.key == "title_tag" }.first.value
        @meta_description = @shopify_page.metafields.select { |attribute| attribute.namespace == 'global' && attribute.key == "description_tag" }.first.value
      else
        @title = ""
        @meta_description = ""
      end
    end
    #get all page_keywords
    #display #page_keyword_stat in view
    @page_keywords = @page.page_keywords
  end
  
  def show
    @shop = Shop.find_by slug: params[:shop_id]
    @page = @shop.pages.find_by slug: params[:page_id]
    @test = @page.tests.find_by id: params[:id]
  end
  
  def create
    @shop = Shop.find_by slug: params[:shop_id]
    @page = @shop.pages.find_by slug: params[:page_id]
    @test = @page.tests.new(test_params)
    shopify_session = ShopifyAPI::Session.new(domain: @shop.shopify_domain, token: @shop.shopify_token, api_version: '2019-10')
    ShopifyAPI::Base.activate_session(shopify_session)
    if @page.store
      if @page.shopify_page_type == "products"
        begin 
          @shopify_page = ShopifyAPI::Product.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
        end
      elsif @page.shopify_page_type == "pages"
        begin 
          @shopify_page = ShopifyAPI::Page.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
        end
      elsif @page.shopify_page_type == "blogs"
        begin 
          @shopify_page = ShopifyAPI::Article.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
          begin 
            @shopify_page = ShopifyAPI::Blog.find(@page.store.shopify_id)
          rescue ActiveResource::ResourceNotFound
            nil
          end
        end
      elsif @page.shopify_page_type == "collections"
        begin 
          @shopify_page = ShopifyAPI::CustomCollection.find(@page.store.shopify_id)
        rescue ActiveResource::ResourceNotFound
          nil
          begin 
            @shopify_page = ShopifyAPI::SmartCollection.find(@page.store.shopify_id)
          rescue ActiveResource::ResourceNotFound
            nil
          end
        end
      end
    end
    respond_to do |format|
      if @shopify_page && @test.save
        @page.update(testing: true)
        title_metafield = ShopifyAPI::Metafield.new(:namespace => "global", :key => "title_tag", :value => @test.title, :value_type => "string")
        desc_metafield = ShopifyAPI::Metafield.new(:namespace => "global", :key => "description_tag", :value => @test.description, :value_type => "string")
        @shopify_page.add_metafield(title_metafield)
        @shopify_page.add_metafield(desc_metafield)
        format.html { redirect_to shop_page_test_path(@shop, @page, @test), notice: 'Test was created and we have updated the page title and meta description tags. The results for this test will be updated in 7, 14 and 30 days.' }
        format.json { render :show, status: :created, location: @test }
      else
        if @shopify_page != nil
          @title = @shopify_page.metafields.select { |attribute| attribute.namespace == 'global' && attribute.key == "title_tag" }.first.value
          @meta_description = @shopify_page.metafields.select { |attribute| attribute.namespace == 'global' && attribute.key == "description_tag" }.first.value
        end
        format.html { redirect_to new_shop_page_test_path(@shop, @page), notice: 'Please sync your Google Search Console account to the Shopify account before you start updating SEO titles.' }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @shop = Shop.find_by slug: params[:shop_id]
    @page = @shop.pages.find_by slug: params[:page_id]
    @test = @page.tests.find_by id: params[:id]
    ending_date = Time.current - 1.day
    two_week_after_ending_date = Time.current - 1.days
    four_week_after_ending_date = Time.current - 1.days
    @test.update(is_test_over: true, ending_date: ending_date, two_week_after_ending_date: two_week_after_ending_date, 
      four_week_after_ending_date: four_week_after_ending_date
    )
    redirect_to shop_page_test_path(@shop, @page, @test), notice: 'Test was successfully ended.' 
  end
  
  private
  def test_params
    params.require(:test).permit(:shop_id, :page_id, 
      :one_week_before_starting_date, :one_week_before_ending_date,
      :two_week_before_starting_date, :two_week_before_ending_date, :starting_date,
      :four_week_before_starting_date, :four_week_before_ending_date, 
      :one_week_after_starting_date, :one_week_after_ending_date, 
      :two_week_after_starting_date, :two_week_after_ending_date, 
      :four_week_after_starting_date, :four_week_after_ending_date, 
      :is_test_over, :title, :description, :previous_title, :previous_description, :ending_date, 
      :one_week_before_clicks, :one_week_before_impressions, :one_week_before_ctr, :one_week_before_position, :one_week_after_clicks, :one_week_after_impressions, :one_week_after_ctr, :one_week_after_position, 
      :two_week_before_clicks, :two_week_before_impressions, :two_week_before_ctr, :two_week_before_position, :two_week_after_clicks, :two_week_after_impressions, :two_week_after_ctr, :two_week_after_position, 
      :four_week_before_clicks, :four_week_before_impressions, :four_week_before_ctr, :four_week_before_position, :four_week_after_clicks, :four_week_after_impressions, :four_week_after_ctr, :four_week_after_position, 
      :one_week_result_clicks, :one_week_result_impressions, :one_week_result_ctr, :one_week_result_position, 
      :two_week_result_clicks, :two_week_result_impressions, :two_week_result_ctr, :two_week_result_position, 
      :four_week_result_clicks, :four_week_result_impressions, :four_week_result_ctr, :four_week_result_position)
  end
end