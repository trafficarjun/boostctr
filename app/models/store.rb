class Store < ApplicationRecord
  belongs_to :page
  validates_presence_of :shopify_id
end
