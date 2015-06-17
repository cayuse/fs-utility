class Price < ActiveRecord::Base
  
  default_scope { order('start DESC') }
  belongs_to :item
  
  before_save :check_dates
  
  validates_uniqueness_of :start, :scope=>:item_id, :message=>"This item already has a price starting on that date. Did you double click update?"
  validates_presence_of :item_id, :cost_in_cents, :price_in_cents, :fmv_in_cents, :start
  
  def <=> (other)
    self.start <=> other.start
  end

  def price
    price_in_cents / 100.0
  end
  
  def cost
    cost_in_cents / 100.0
  end
  
  def fmv
    fmv_in_cents / 100.0
  end
  
  def price=(num)
    self.price_in_cents = (num * 100.0).to_i
  end
  
  def cost=(num)
    self.cost_in_cents =(num * 100.0).to_i
  end
  
  def fmv=(num)
    self.fmv_in_cents = (num * 100.0).to_i
  end
  
  
  private
  def check_dates
    if expire
    expire >= start
    else
      return true
    end
  end

end
