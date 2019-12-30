class Admin::Shops::PagesController < ApplicationController
  
  def show
    @shop = Shop.find_by slug: params[:shop_id]
    @page = @shop.pages.find_by slug: params[:id]
    @tests = @page.tests
    if @page.tests.count == 0
      redirect_to new_admin_shop_page_test_path(@shop, @page) 
    else
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
    end
  end
end