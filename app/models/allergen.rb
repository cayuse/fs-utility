class Allergen < ActiveRecord::Base
  has_many :itemallergens
  has_many :items, :through => :itemallergens
  has_many :studentallergens
  has_many :students, :through => :studentallergens
end
