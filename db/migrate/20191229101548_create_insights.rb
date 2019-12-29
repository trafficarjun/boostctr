class CreateInsights < ActiveRecord::Migration[6.0]
  def change
    create_table :insights do |t|
      t.string :clicks
      t.string :impressions
      t.string :position
      t.integer :page_id
      t.integer :shop_id
      t.text :shopify_page_type
      t.float :ctr
      t.timestamps
    end
  end
end
