class CreatePageStats < ActiveRecord::Migration[6.0]
  def change
    create_table :page_stats do |t|
      t.integer :page_id
      t.integer :stat_id
      t.timestamps
    end
  end
end
