class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.text :url
      t.boolean :testing
      t.text :content
      t.integer :shop_id
      t.text :slug
      t.string :expected_ctr
      t.text :handle
      t.text :shopify_page_type

      t.timestamps
    end
  end
end
