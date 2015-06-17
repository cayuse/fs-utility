class Diet < ActiveRecord::Base
  belongs_to :student
  belongs_to :schoolyear
  has_many   :diagnoses
  belongs_to :user
 
  accepts_nested_attributes_for :diagnoses

end
