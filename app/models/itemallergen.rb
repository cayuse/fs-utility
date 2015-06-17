class Itemallergen < ActiveRecord::Base
  belongs_to :item
  belongs_to :allergen
end
