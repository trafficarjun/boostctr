class PageKeyword < ApplicationRecord
  has_many :page_keyword_stats, dependent: :destroy
  has_many :stats, through: :page_keyword_stats
  
  belongs_to :page, touch: true 
  belongs_to :keyword, touch: true 
  belongs_to :shop, touch: true 
  
  validates :keyword_id, :uniqueness => { :scope => :page_id }
end
