class Usage < ActiveRecord::Base
  has_and_belongs_to_many :itemtypes
end
