class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.text :title
      t.text :description
      t.text :previous_title
      t.text :previous_description
      t.datetime :ending_date
      t.string :two_week_before_clicks
      t.string :two_week_before_impressions
      t.string :two_week_before_ctr
      t.string :two_week_before_position
      t.string :two_week_after_clicks
      t.string :two_week_after_impressions
      t.string :two_week_after_ctr
      t.string :two_week_after_position
      t.string :four_week_before_clicks
      t.string :four_week_before_impressions
      t.string :four_week_before_ctr
      t.string :four_week_before_position
      t.string :four_week_after_clicks
      t.string :four_week_after_impressions
      t.string :four_week_after_ctr
      t.string :four_week_after_position
      t.string :two_week_result_clicks
      t.string :two_week_result_impressions
      t.string :two_week_result_ctr
      t.string :two_week_result_position
      t.string :four_week_result_clicks
      t.string :four_week_result_impressions
      t.string :four_week_result_ctr
      t.string :four_week_result_position
      t.integer :shop_id
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.integer :page_id
      t.boolean :is_test_over, default: false
      t.datetime :two_week_before_starting_date
      t.datetime :two_week_before_ending_date
      t.datetime :four_week_before_starting_date
      t.datetime :four_week_before_ending_date
      t.datetime :two_week_after_starting_date
      t.datetime :two_week_after_ending_date
      t.datetime :four_week_after_starting_date
      t.datetime :four_week_after_ending_date
      t.datetime :starting_date
      t.string :one_week_before_clicks
      t.string :one_week_before_impressions
      t.string :one_week_before_ctr
      t.string :one_week_before_position
      t.string :one_week_after_clicks
      t.string :one_week_after_impressions
      t.string :one_week_after_ctr
      t.string :one_week_after_position
      t.string :one_week_result_clicks
      t.string :one_week_result_impressions
      t.string :one_week_result_ctr
      t.string :one_week_result_position
      t.datetime :one_week_before_starting_date
      t.datetime :one_week_before_ending_date
      t.datetime :one_week_after_starting_date
      t.datetime :one_week_after_ending_date
      t.boolean :one_week_before_updated, default: true
      t.boolean :two_week_before_updated, default: true
      t.boolean :four_week_before_updated, default: true
      t.boolean :one_week_after_updated, default: true
      t.boolean :two_week_after_updated, default: true
      t.boolean :four_week_after_updated, default: true
      t.boolean :four_week_result_ctr_greater
      t.boolean :two_week_result_ctr_greater
      t.boolean :one_week_result_ctr_greater
      t.boolean :four_week_result_clicks_greater
      t.boolean :two_week_result_clicks_greater
      t.boolean :one_week_result_clicks_greater
      t.boolean :four_week_result_impressions_greater
      t.boolean :two_week_result_impressions_greater
      t.boolean :one_week_result_impressions_greater
      t.boolean :four_week_result_position_greater
      t.boolean :two_week_result_position_greater
      t.boolean :one_week_result_position_greater
      
      
      
    end
  end
end


