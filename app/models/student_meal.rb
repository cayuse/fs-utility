class StudentMeal < ActiveRecord::Base
  belongs_to :student
  belongs_to :meal
end
