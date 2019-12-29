class AddIndexesUnique < ActiveRecord::Migration[6.0]
  def change
    add_index :page_keywords, [:keyword_id, :page_id], unique: true
    add_index :keywords, [:shop_id, :name], unique: true
    add_index :page_stats, [:stat_id, :page_id, :created_at], unique: true, name: 'unique_page_stat_date'
    add_index :page_keyword_stats, [:stat_id, :page_keyword_id, :created_at], unique: true, name: 'uniq_page_stat_key_date'
  end
end
