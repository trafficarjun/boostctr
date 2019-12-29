class CreatePageKeywordStats < ActiveRecord::Migration[6.0]
  def change
    create_table :page_keyword_stats do |t|
      t.integer :stat_id
      t.integer :page_keyword_id
      t.timestamps
    end
  end
end
