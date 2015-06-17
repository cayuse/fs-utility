class Nutritional < ActiveRecord::Base
  belongs_to :foodvendor
      #set_property :delta => true

  has_attached_file :attachment

  def <=> (other)
    foodvendor.name <=> other.foodvendor.name
  end

end
