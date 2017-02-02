class Monthlyinvitem < ActiveRecord::Base
  belongs_to :monthlyinv
  belongs_to :item
  belongs_to :storeloc
  belongs_to :price

  validates_uniqueness_of :item_id, :scope => [:monthlyinv_id, :storeloc_id]
  def <=> (other)
    other.item.sort.to_i <=> item.sort.to_i
  end
end
