class Plan < ActiveRecord::Base
  has_many :shop_plans
  has_many :shops, through: :shop_plans
end
