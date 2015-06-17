class Studentallergen < ActiveRecord::Base
  belongs_to :student
  belongs_to :allergen
end
