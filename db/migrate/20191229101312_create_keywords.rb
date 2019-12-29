class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.text :name
      t.integer :shop_id
      t.text :slug
      t.boolean :includes_brand_name
      t.integer :keyword_count
      t.timestamps
    end
  end
end
