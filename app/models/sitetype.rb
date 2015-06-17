class Sitetype < ActiveRecord::Base
  has_many :sitemizations
  has_many :items, :through => :sitemizations
  has_many :sites
  has_many :weeklyorderreqs
  has_many :monthlyinvreqs
  
  def <=>(other)
    name <=> other.name
  end
  
  def self.all_with_days
    #Sitetype.find(:all, :order=>:id, :conditions=>["mon=? OR tue=? OR wed=? OR thu=? or fri=?", 't', 't', 't', 't', 't'])
    Sitetype.order(:id).where("mon = 't' OR tue = 't' OR wed = 't' OR thu = 't' OR fri = 't'")
  end
  
  def self.not_empty_sitetypes
    types = []
    for sitetype in Sitetype.includes(:sites)
      types.push sitetype if sitetype.sites.count > 0
    end
    return types
  end
  
  def self.sitetype_orderreqs
    types = {}
    Sitetype.not_empty_sitetypes.each do |sitetype|
      types[sitetype] = Weeklyorderreq.where(sitetype_id: sitetype.id)
    end
    return types
  end
  
  def self.sitetype_invreqs
    types = {}
    Sitetype.all.each do |sitetype|
      types[sitetype] = Monthlyinvreq.where(sitetype_id: sitetype.id)
    end
    return types
  end
  
end
