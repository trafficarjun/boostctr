class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.string :clicks
      t.string :impressions
      t.string :ctr
      t.string :position
      t.integer :shop_id
      t.timestamps
    end
  end
end
