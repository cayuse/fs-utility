class DiagnosisCategory < ActiveRecord::Base
  belongs_to :diagnosis
  belongs_to :category
end
