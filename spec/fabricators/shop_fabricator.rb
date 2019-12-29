Fabricator(:shop)  do
  shopify_domain 'boostctr1.myshopify.com'
  shopify_token 'd2c35ee685a7ea35f8312b3241232340'
  email 'arjunrajkumars@gmail.com'
  domain 'boostctr1.myshopify.com'
  subscribed true
  google_token Rails.application.credentials.arjun_shopify_google_token
  google_refresh_token Rails.application.credentials.arjun_shopify_google_refresh_token
end

