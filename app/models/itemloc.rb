class Itemloc < ActiveRecord::Base
  belongs_to :storeloc
  belongs_to :item
  
  def <=> (other)
    sort.to_i <=> other.sort.to_i
  end
  
end
