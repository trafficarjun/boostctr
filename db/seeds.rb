# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shop.delete_all
Page.delete_all

Shop.create!(
  shopify_domain: 'regular-shop.myshopify.com', 
  shopify_token: 'token', email: 'email@regular-shop.com', domain: 'regular-shop.com', subscribed: true
)

Page.create!(url: '/products.html', shop: Shop.first)