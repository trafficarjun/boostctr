class AddIndexPageShopUrl < ActiveRecord::Migration[6.0]
  def change
    add_index :pages, [:shop_id, :url], unique: true
  end
end
