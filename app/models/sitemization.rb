class Sitemization < ActiveRecord::Base
  belongs_to :item
  belongs_to :sitetype
end
