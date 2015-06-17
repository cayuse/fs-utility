class Worksheet < ActiveRecord::Base
  
    has_attached_file :sheet
    do_not_validate_attachment_file_type :sheet


  def <=> (other)
    worksheet.name <=> other.worksheet.name
  end
  
end
