class CreateShopPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :shop_plans do |t|
      t.integer :shop_id
      t.integer :plan_id
      t.timestamps
    end
  end
end
