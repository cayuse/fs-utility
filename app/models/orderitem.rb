class Orderitem < ActiveRecord::Base
  
  belongs_to :weeklydfcorder
  belongs_to :item
  
  validates_uniqueness_of :item_id, :scope => :weeklydfcorder_id
  
  QTYS    = ["mon", "tue", "wed", "thu", "fri"]
  DATES   = ["mondate", "tuedate", "weddate", "thudate", "fridate"]
  CHARGES = ["moncharge", "tuecharge", "wedcharge", "thucharge", "fricharge"]
  CHARGESCENTS = ["moncharge_in_cents", "tuecharge_in_cents", "wedcharge_in_cents", "thucharge_in_cents", "fricharge_in_cents"]
  
  def <=>(other)
    item.sort <=> other.item.sort
  end
  
  def price
    self.item.price_on_date(self.weeklydfcorder.weeklyorderreq.week).price
  end
  def price_in_cents
    self.item.price_on_date(self.weeklydfcorder.weeklyorderreq.week).price_in_cents
  end
  
  def mondate
    weeklydfcorder.weeklyorderreq.week
  end

  def tuedate
    weeklydfcorder.weeklyorderreq.week + 1.day
  end
  
  def weddate
    weeklydfcorder.weeklyorderreq.week + 2.days
  end
  
  def thudate
    weeklydfcorder.weeklyorderreq.week + 3.days
  end
  
  def fridate
    weeklydfcorder.weeklyorderreq.week + 4.days
  end
  
  def mon
    monqty || 0
  end
  def tue
    tueqty || 0
  end
  def wed
    wedqty || 0
  end
  def thu
    thuqty || 0
  end
  def fri
    friqty || 0
  end
  
  def moncharge
    mon * price
  end
  def tuecharge
    tue * price
  end
  def wedcharge
    wed * price
  end
  def thucharge
    thu * price
  end
  def fricharge
    fri * price
  end
  
  def moncharge_in_cents
    mon * price_in_cents
  end
  def tuecharge_in_cents
    tue * price_in_cents
  end
  def wedcharge_in_cents
    wed * price_in_cents
  end
  def thucharge_in_cents
    thu * price_in_cents
  end
  def fricharge_in_cents
    fri * price_in_cents
  end
  
  def allqty
    mon + tue + wed + thu + fri
  end
  def allcharge
    (mon + tue + wed + thu + fri) * price
  end

end
