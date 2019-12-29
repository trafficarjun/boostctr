# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_29_103202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clicks", force: :cascade do |t|
    t.integer "shop_id"
    t.string "ctr_type"
    t.integer "rank"
    t.integer "ctr"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "insights", force: :cascade do |t|
    t.string "clicks"
    t.string "impressions"
    t.string "position"
    t.integer "page_id"
    t.integer "shop_id"
    t.text "shopify_page_type"
    t.float "ctr"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "keyword_stats", force: :cascade do |t|
    t.integer "stat_id"
    t.integer "keyword_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.text "name"
    t.integer "shop_id"
    t.text "slug"
    t.boolean "includes_brand_name"
    t.integer "keyword_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id", "name"], name: "index_keywords_on_shop_id_and_name", unique: true
  end

  create_table "page_keyword_stats", force: :cascade do |t|
    t.integer "stat_id"
    t.integer "page_keyword_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stat_id", "page_keyword_id", "created_at"], name: "uniq_page_stat_key_date", unique: true
  end

  create_table "page_keywords", force: :cascade do |t|
    t.integer "page_id"
    t.integer "keyword_id"
    t.integer "shop_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keyword_id", "page_id"], name: "index_page_keywords_on_keyword_id_and_page_id", unique: true
  end

  create_table "page_stats", force: :cascade do |t|
    t.integer "page_id"
    t.integer "stat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stat_id", "page_id", "created_at"], name: "unique_page_stat_date", unique: true
  end

  create_table "pages", force: :cascade do |t|
    t.text "url"
    t.boolean "testing"
    t.text "content"
    t.integer "shop_id"
    t.text "slug"
    t.string "expected_ctr"
    t.text "handle"
    t.text "shopify_page_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id", "url"], name: "index_pages_on_shop_id_and_url", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shop_plans", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "plan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "domain"
    t.string "slug"
    t.boolean "subscribed", default: true
    t.string "google_website"
    t.string "brand_name"
    t.string "google_token"
    t.string "google_refresh_token"
    t.string "google_email"
    t.datetime "expiresat"
    t.boolean "shopify_domain_google_website_match", default: true
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "stats", force: :cascade do |t|
    t.string "clicks"
    t.string "impressions"
    t.string "ctr"
    t.string "position"
    t.integer "shop_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "shopify_id"
    t.integer "page_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tests", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.text "previous_title"
    t.text "previous_description"
    t.datetime "ending_date"
    t.string "two_week_before_clicks"
    t.string "two_week_before_impressions"
    t.string "two_week_before_ctr"
    t.string "two_week_before_position"
    t.string "two_week_after_clicks"
    t.string "two_week_after_impressions"
    t.string "two_week_after_ctr"
    t.string "two_week_after_position"
    t.string "four_week_before_clicks"
    t.string "four_week_before_impressions"
    t.string "four_week_before_ctr"
    t.string "four_week_before_position"
    t.string "four_week_after_clicks"
    t.string "four_week_after_impressions"
    t.string "four_week_after_ctr"
    t.string "four_week_after_position"
    t.string "two_week_result_clicks"
    t.string "two_week_result_impressions"
    t.string "two_week_result_ctr"
    t.string "two_week_result_position"
    t.string "four_week_result_clicks"
    t.string "four_week_result_impressions"
    t.string "four_week_result_ctr"
    t.string "four_week_result_position"
    t.integer "shop_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "page_id"
    t.boolean "is_test_over", default: false
    t.datetime "two_week_before_starting_date"
    t.datetime "two_week_before_ending_date"
    t.datetime "four_week_before_starting_date"
    t.datetime "four_week_before_ending_date"
    t.datetime "two_week_after_starting_date"
    t.datetime "two_week_after_ending_date"
    t.datetime "four_week_after_starting_date"
    t.datetime "four_week_after_ending_date"
    t.datetime "starting_date"
    t.string "one_week_before_clicks"
    t.string "one_week_before_impressions"
    t.string "one_week_before_ctr"
    t.string "one_week_before_position"
    t.string "one_week_after_clicks"
    t.string "one_week_after_impressions"
    t.string "one_week_after_ctr"
    t.string "one_week_after_position"
    t.string "one_week_result_clicks"
    t.string "one_week_result_impressions"
    t.string "one_week_result_ctr"
    t.string "one_week_result_position"
    t.datetime "one_week_before_starting_date"
    t.datetime "one_week_before_ending_date"
    t.datetime "one_week_after_starting_date"
    t.datetime "one_week_after_ending_date"
    t.boolean "one_week_before_updated", default: true
    t.boolean "two_week_before_updated", default: true
    t.boolean "four_week_before_updated", default: true
    t.boolean "one_week_after_updated", default: true
    t.boolean "two_week_after_updated", default: true
    t.boolean "four_week_after_updated", default: true
    t.boolean "four_week_result_ctr_greater"
    t.boolean "two_week_result_ctr_greater"
    t.boolean "one_week_result_ctr_greater"
    t.boolean "four_week_result_clicks_greater"
    t.boolean "two_week_result_clicks_greater"
    t.boolean "one_week_result_clicks_greater"
    t.boolean "four_week_result_impressions_greater"
    t.boolean "two_week_result_impressions_greater"
    t.boolean "one_week_result_impressions_greater"
    t.boolean "four_week_result_position_greater"
    t.boolean "two_week_result_position_greater"
    t.boolean "one_week_result_position_greater"
  end

end
