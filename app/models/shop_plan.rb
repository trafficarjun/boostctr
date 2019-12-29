class ShopPlan < ApplicationRecord
  belongs_to :shop, touch: true 
  belongs_to :plan, touch: true 
end
