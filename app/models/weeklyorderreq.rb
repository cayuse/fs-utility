class Weeklyorderreq < ActiveRecord::Base
  VALID_ITEM_TYPES = Usage.find_by_name("DFC Order").itemtype_ids

  belongs_to :sitetype
  has_many :weeklydfcorders
  #has_many :items, :through => :weeklydfcorders
  #has_many :sites, :through => :weeklydfcorders
  has_many :orderitems, :through => :weeklydfcorders
  has_many :items, :through => :orderitems
  
  validates_presence_of :week, :due
  validates_uniqueness_of :week, :scope=>:sitetype_id, :message=>"This week is already defined for this site type."

  def orders_for_site(site)
    self.weeklydfcorders.find(:all, :include=>:item, :conditions=>['site_id = ?', site.id])
  end


end
