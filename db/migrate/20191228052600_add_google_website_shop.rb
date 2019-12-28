class AddGoogleWebsiteShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :google_website, :string
    add_column :shops, :brand_name, :string
  end
end
