class KeywordStat < ApplicationRecord
  belongs_to :keyword, touch: true 
  belongs_to :stat, touch: true 
end
