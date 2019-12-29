class PageStat < ApplicationRecord
  belongs_to :page, touch: true 
  belongs_to :stat, touch: true 
end
