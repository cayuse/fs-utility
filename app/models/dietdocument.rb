class Dietdocument < ActiveRecord::Base
  
  has_attached_file :dietscan
  do_not_validate_attachment_file_type :dietscan
  
  validates_presence_of :student_id
  belongs_to :student
end
