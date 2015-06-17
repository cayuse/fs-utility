class Monthlyinvreq < ActiveRecord::Base
  belongs_to :sitetype
  has_many :monthlyinvs
  has_many :monthlyinvitems, :through=> :monhtlyinvs
  has_many :items, :through=> :monthlyinvitems
  
  VALID_ITEM_TYPES = Usage.find_by_name("Monthly Inventory").itemtype_ids.uniq
  
  ## This is a terrible way to do this, but I don't have a better one at the moment.
  ## The numbers below correspond to Itemtype ids, the itemtype_id field in these invitems' item records.
  FOOD      = [3, 5, 6, 7, 8, 9, 19]
  GOVT_FOOD = [15, 16]
  FAIR_MKT  = GOVT_FOOD
  TOT_FOOD  = FOOD + GOVT_FOOD
  
  SUPPLY    = [4, 10, 14]
  TOT_INV   = VALID_ITEM_TYPES


  validates_presence_of :month, :start, :due
  validates_uniqueness_of :month, :scope=>:sitetype_id, :message=>"This month is already defined for this site type."

  def <=> (other)
    sitetype_id <=> other.sitetype_id
  end

end
