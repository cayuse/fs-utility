class ConditionCategory < ActiveRecord::Base
  belongs_to :condition
  belongs_to :category
end
