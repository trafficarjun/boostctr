class CreatePageKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :page_keywords do |t|
      t.integer :page_id
      t.integer :keyword_id
      t.integer :shop_id
      t.timestamps
    end
  end
end
