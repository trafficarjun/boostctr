class PageKeywordStat < ApplicationRecord
  belongs_to :stat, touch: true 
  belongs_to :page_keyword, touch: true 
end
