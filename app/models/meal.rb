class Meal < ActiveRecord::Base
  has_many :student_meals
  has_many :students, :through => :student_meals
end
