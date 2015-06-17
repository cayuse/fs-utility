class Diagnosis < ActiveRecord::Base
  belongs_to :diet
  belongs_to :condition
  belongs_to :category
  has_many   :diagnoses

end
