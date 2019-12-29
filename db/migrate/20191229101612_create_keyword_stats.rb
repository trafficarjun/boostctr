class CreateKeywordStats < ActiveRecord::Migration[6.0]
  def change
    create_table :keyword_stats do |t|
      t.integer :stat_id
      t.integer :keyword_id
      t.timestamps
    end
  end
end
