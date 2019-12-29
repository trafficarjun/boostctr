class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :shopify_id
      t.integer :page_id
      t.timestamps
    end
  end
end
