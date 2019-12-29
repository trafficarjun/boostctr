class Stat < ApplicationRecord
  has_many :page_keyword_stats, dependent: :destroy
  has_many :page_keywords, through: :page_keyword_stats
  
  has_many :page_stats, dependent: :destroy
  has_many :pages, through: :page_stats
  
  has_many :keyword_stats, dependent: :destroy
  has_many :keywords, through: :keyword_stats
  
  validates_presence_of :clicks, :ctr
  
  belongs_to :shop
  
  scope :highest_gain, -> { order(gain: :desc) }
end
