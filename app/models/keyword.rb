class Keyword < ApplicationRecord
  belongs_to :shop
  has_many :page_keywords, dependent: :destroy
  has_many :pages, through: :page_keywords
  
  has_many :keyword_stats, dependent: :destroy
  has_many :stats, through: :keyword_stats
  
  validates_uniqueness_of :name, :scope => :shop_id
  
  validates_presence_of :name
  include Sluggable
  sluggable_column :name
  
  def get_clicks_page(page)
    self.page_keywords.where(page_id: page.id).first.stats.pluck(:clicks).first
  end
  
  def get_impressions_page(page)
    self.page_keywords.where(page_id: page.id).first.stats.pluck(:impressions).first
  end
  
  def get_ctr_page(page)
    self.page_keywords.where(page_id: page.id).first.stats.pluck(:ctr).first
  end
  
  def get_position_page(page)
    self.page_keywords.where(page_id: page.id).first.stats.pluck(:position).first
  end
end
