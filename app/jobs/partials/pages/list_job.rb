class Partials::Pages::ListJob < ApplicationJob
  queue_as :default

  # This will push the updated partial to the user via ActionCable.
  def perform(shop_id)
    # 'comments/list' is the key we defined in the view, and is passed to the RealtimePartialChannel via stimulus.
    # `render(Comment.all)` is a little bit of rails magic, that will return the same HTML as running
    # <%= render(Comment.all) %> in our erb view.
    #@pages = Page.all.where.not(shopify_id: nil)
    @shop = Shop.find(shop_id)
    @pages = @shop.pages
    RealtimePartialChannel.broadcast_to('pages/list', {
      body: ApplicationController.render(@pages, layout: false)
    })
  end
end