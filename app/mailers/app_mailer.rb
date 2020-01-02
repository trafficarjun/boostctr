class AppMailer < ActionMailer::Base
  def send_shop_sign_in(shopify_domain)
    @shopify_domain = shopify_domain
    mail to: "arjunrajkumars@gmail.com", from: "arjun@boostctr.co", subject: "Shop signed in"
  end
end
