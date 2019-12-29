class Click < ApplicationRecord
  belongs_to :shop
  validates_presence_of :ctr_type, :rank, :ctr
end
