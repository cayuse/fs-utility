class Note < ActiveRecord::Base
  belongs_to :student
  validates_presence_of :student_id
end
