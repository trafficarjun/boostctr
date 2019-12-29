class CreateClicks < ActiveRecord::Migration[6.0]
  def change
    create_table :clicks do |t|
      t.integer :shop_id
      t.string :ctr_type
      t.integer :rank
      t.integer :ctr
      t.timestamps
    end
  end
end
