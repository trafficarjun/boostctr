class Insight < ApplicationRecord
  belongs_to :page
  belongs_to :shop
  validates_presence_of :ctr, :shopify_page_type
end
