class Itemtype < ActiveRecord::Base
  has_many :items
  has_and_belongs_to_many :usages
  
  
  def <=> (other)   
    id <=> other.id   
  end
  
end
