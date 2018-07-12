class Item < ActiveRecord::Base

  belongs_to :itemtype
  has_many :prices, -> { order 'start' }, :dependent => :destroy
  has_many :sitemizations
  has_many :sitetypes, :through => :sitemizations
  has_many :orderitems
  has_many :weeklydfcorders, :through => :orderitems
  has_many :monthlyinvitems
  has_many :monthlyinvs, :through => :monthlyinvitems
  has_many :monthlysitems
  has_many :monthlysites, :through => :monthlysitems, :source=> "site"
  has_many :itemallergens
  has_many :allergens, :through => :itemallergens
  has_many :itemlocs, :dependent => :destroy

  
  
  accepts_nested_attributes_for :prices
  validates_presence_of :itemtype
  validates_uniqueness_of :name

  attr_accessor :test

  #after_save :save_sitetype_collections

    def for_type(type)
      find(:all, :conditions=> {:sitetype => type})
    end

  def update_price(price)
    if Time.now - self.current_price.created_at < 10
      return
    end
    oldprice = self.current_price
    newprice = self.prices.build
    newprice.price = price[:price].to_f
    newprice.cost  = price[:cost].to_f
    newprice.fmv   = price[:fmv].to_f
    newprice.start = Date.strptime(price[:start], "%m/%d/%Y")
    oldprice.expire = newprice.start

    if oldprice.save && newprice.save
      return newprice
    else
      return nil
    end
  end

  def <=> (other)
    name <=> other.name
  end

  def previous
#    Item.find(:last, :order => "sort",  :conditions => ["sort < ?", sort])
    Item.where("sort < ?", sort).order("sort").last
  end

  def next
#    Item.find(:first, :order=>:sort,  :conditions => ["sort > ?", sort])
    Item.where("sort > ?", sort).order("sort").first
  end

  def current_price
    Price.find_by_item_id self
  end

  def todays_price
    price_on_date(Date.today)
  end

  def price_on_date(date)
    prices = self.prices.sort
    return prices.last if prices.last.start <= date
    price = Price.where(item_id: self).where("start <= ? and expire > ?", date, date).first
    if price
      return price
    end
    prices.last
  end

  def expired?
    return self.current_price.expire ? true : false
  end

#  def self.search(search, page)
#    paginate :per_page => 100, :page => page,
#             :conditions => ['name like ?', "%#{search}%"],
##             :include => :prices,
#             :order => :sort
#  end

  #def sitetype_ids=(sitetype_ids)
   # @new_sitetype_ids = sitetype_ids
  #end

#  def save_sitetype_collections
#    if @new_sitetype_ids
#      sitemizations.each do |sitemization|
#        sitemization.destroy unless @new_sitetype_ids.include? sitemization.sitetype_id
#      end

#      @new_sitetype_ids.each do |id|
#        self.sitemizations.create(:sitetype_id => id) unless sitemizations.any? { |d| d.sitetype_id == id }
#      end
#    end
#  end

end
