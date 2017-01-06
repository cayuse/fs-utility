

 => #<Item
 
 id: nil,
 name: nil,
 units: nil,
 issue: nil,
 sort: nil,
 created_at: nil,
 updated_at: nil,
 itemtype_id: nil,
 mon: nil,
 tue: nil,
 wed: nil,
 thu: nil,
 fri: nil> 
mfgname
mfgcode
ordercode


# To expire all the old items
types = Itemtype.find ((7..19).to_a - [13,17] + [4])
a = Item.where(itemtype: types)
day = Date.today.monday - 2 #saturday
a.each do |b|
  unless b.expired?
   c = b.current_price
   c.expire = day
   c.save!
 end
end

# to remove all the old storelocs

Itemloc.all.destroy_all;1


# P and R updates

#GLOVES-VINYL, GOL-7571, MEDIUM PF ELASTIQUE GLOVE 1M/CS ,CS, 3, $29.00
#HATS-HAT/HAIR/SHOE, CEL-BP-400R, WHITE BEARD RESTRAINT 10/100, CS, 1, $25.25
require 'csv'
items = CSV.read("/home/shared/inventory_imports/p and r raw.csv")
;items = IO::readlines "p and r raw.csv"
items = items.uniq
items.pop

#ofile = File.open("/home/shared/inventory_imports/p and r fixed.csv", 'w')
#ofile = CSV.open("/home/shared/inventory_imports/p and r fixed.csv", 'w')

items.each do |itm|
  itm[0] = itm[0].titleize
  itm[4] = (itm[2].split(" ").last)
  itm[2].gsub!(" #{itm[2].split(" ").last}", "")
  itm[2] = itm[2].titleize
  itm[2].gsub!("\"", " Inch")
  itm[2].gsub!("\'", " Foot")
  itm[5].gsub!("$","")
  itm.pop
  #ofile << itm
end

## results
##  => ["Apron/Bib", "GOL-1532-1", "28x46 Plastic Aprons", "BOX", "20/50", "1.65"] 
##  => #<Item id: nil, name: nil, units: nil, issue: nil, sort: nil, created_at: nil, updated_at: nil, itemtype_id: nil, mon: nil, tue: nil, wed: nil, thu: nil, fri: nil, mfgname: nil, mfgcode: nil, ordercode: nil> 
day = Date.today - 2
items.each do |itm|
  i = Item.where(name: itm[2])
  i = i.first
  i ||= Item.new
  i.name = itm[2]
  i.issue = itm[3]
  i.units = itm[4]
  i.mfgname = itm[0]
  i.mfgcode = itm[1]
  i.ordercode = itm[1]
  i.itemtype_id = 4
  i.save!
  b = i.prices.build
  b.price_in_cents = itm[5].to_f * 100
  b.cost_in_cents = itm[5].to_f * 100
  b.fmv_in_cents = 0
  b.start = day
  b.save!
end

#### gold star
items = CSV.read("/home/shared/inventory_imports/Gold Star raw.csv");1
items = items.uniq;1

items.each do |itm|
  itm[3] = itm[3].titleize
  itm[10] ||= itm[2]
  itm[10] = itm[10].titleize
  itm[8] ||= ""
  itm[9] ||= ""
  itm[8].gsub!("$","")
  itm[9].gsub!("$","")
end;1


#<Itemtype id: 3, name: "DFC Order Food", created_at: "2009-01-07 18:25:27", updated_at: "2009-11-09 23:31:26", colorcode: "d55db6">
#<Itemtype id: 4, name: "DFC Order Supplies", created_at: "2009-01-07 18:25:39", updated_at: "2009-11-09 23:31:34", colorcode: "bf5dd5">
#<Itemtype id: 5, name: "Warehouse Order Dry Goods", created_at: "2009-01-07 18:26:05", updated_at: "2009-11-09 23:32:01", colorcode: "915dd5">
#<Itemtype id: 6, name: "Warehouse Order Frozen", created_at: "2009-01-07 18:26:17", updated_at: "2009-11-10 00:39:29", colorcode: "7f72f8">
#<Itemtype id: 7, name: "Frozen Food Items", created_at: "2009-01-07 18:26:32", updated_at: "2009-11-10 00:39:29", colorcode: "7281f8">
#<Itemtype id: 8, name: "Refrigerated Food Items", created_at: "2009-01-07 18:26:42", updated_at: "2009-11-10 00:39:29", colorcode: "72a4f8">
#<Itemtype id: 9, name: "Dry Food Items", created_at: "2009-01-07 18:28:18", updated_at: "2009-11-10 00:39:29", colorcode: "5db2d5">
#<Itemtype id: 10, name: "Supply Items", created_at: "2009-01-07 18:26:53", updated_at: "2009-11-10 00:39:29", colorcode: "5dd5b8">
#<Itemtype id: 11, name: "Capital Equipment", created_at: "2009-01-07 18:28:11", updated_at: "2009-11-10 00:39:29", colorcode: "5dd584">
#<Itemtype id: 12, name: "Small Wares", created_at: "2009-01-07 18:28:18", updated_at: "2009-11-10 00:39:29", colorcode: "72d55d">
#<Itemtype id: 14, name: "Warehouse Order Supplies", created_at: "2009-02-23 23:17:11", updated_at: "2009-11-10 00:39:29", colorcode: "c2d55d">
#<Itemtype id: 15, name: "Government Comodity Dry", created_at: "2009-04-10 15:31:32", updated_at: "2009-11-10 00:39:29", colorcode: "d5aa5d">
#<Itemtype id: 16, name: "Government Comodity Frozen", created_at: "2009-04-10 15:31:53", updated_at: "2009-11-10 00:39:29", colorcode: "d57b5d">
#<Itemtype id: 18, name: "Plastic Wrap and Containers", created_at: "2009-10-09 16:38:56", updated_at: "2009-11-10 00:39:29", colorcode: "d55d79">
#<Itemtype id: 19, name: "DFC Order Food + Inventory", created_at: "2010-11-03 16:14:47", updated_at: "2010-11-03 16:14:47", colorcode: nil>


#<Storeloc id: 90, site_id: 8, name: "Warehouse Order Dry Goods", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 91, site_id: 8, name: "Warehouse Order Frozen", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 92, site_id: 8, name: "Frozen Food Items", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 93, site_id: 8, name: "Refrigerated Food Items", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 94, site_id: 8, name: "Dry Food Items", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 97, site_id: 8, name: "Government Comodity Dry", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 98, site_id: 8, name: "Government Comodity Frozen", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 99, site_id: 8, name: "Plastic Wrap and Containers", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 233, site_id: 21, name: "Storage Shed  #2", number: 1, created_at: "2010-12-16 20:01:24", updated_at: "2010-12-16 20:01:24">
#<Storeloc id: 235, site_id: 21, name: "Freezer   outside", number: 3, created_at: "2010-12-16 20:02:07", updated_at: "2010-12-16 20:02:07">
#<Storeloc id: 237, site_id: 21, name: "Refrigerator   walk-in", number: 5, created_at: "2010-12-16 20:02:46", updated_at: "2010-12-16 20:02:46">
#<Storeloc id: 305, site_id: 13, name: "Walk-in Refrigator", number: 1, created_at: "2011-01-07 16:28:46", updated_at: "2011-01-07 16:28:46">
#<Storeloc id: 296, site_id: 13, name: "Rear Pantry-Chip Room", number: 3, created_at: "2011-01-07 16:27:44", updated_at: "2011-01-07 16:30:38">
#<Storeloc id: 293, site_id: 2, name: "Freezer", number: 0, created_at: "2011-01-07 16:27:07", updated_at: "2011-01-07 16:27:07">
#<Storeloc id: 295, site_id: 2, name: "Walk - In", number: 1, created_at: "2011-01-07 16:27:36", updated_at: "2011-01-07 16:27:36">
#<Storeloc id: 297, site_id: 2, name: "Pantry", number: 2, created_at: "2011-01-07 16:27:49", updated_at: "2011-01-07 16:27:49">
#<Storeloc id: 300, site_id: 2, name: "Reach In #1", number: 3, created_at: "2011-01-07 16:28:16", updated_at: "2011-01-07 16:28:16">
#<Storeloc id: 302, site_id: 2, name: "Reach In #2", number: 4, created_at: "2011-01-07 16:28:28", updated_at: "2011-01-07 16:28:28">
#<Storeloc id: 304, site_id: 2, name: "Container", number: 5, created_at: "2011-01-07 16:28:43", updated_at: "2011-01-07 16:28:43">
#<Storeloc id: 306, site_id: 2, name: "Dry Storage Room", number: 6, created_at: "2011-01-07 16:29:10", updated_at: "2011-01-07 16:29:10">
#<Storeloc id: 276, site_id: 1, name: "STORAGE AREA", number: 0, created_at: "2011-01-07 16:25:47", updated_at: "2011-01-07 16:25:47">
#<Storeloc id: 280, site_id: 1, name: "OFFICE/STORAGE", number: 1, created_at: "2011-01-07 16:26:03", updated_at: "2011-01-07 16:26:03">
#<Storeloc id: 335, site_id: 1, name: "KITCHEN CABINETS", number: 2, created_at: "2011-01-12 21:50:33", updated_at: "2011-01-12 21:50:33">
#<Storeloc id: 242, site_id: 1, name: "OUTSIDE FREEZER", number: 3, created_at: "2011-01-07 16:24:02", updated_at: "2011-01-07 16:24:02">
#<Storeloc id: 318, site_id: 22, name: "frozen food item", number: 1, created_at: "2011-01-07 16:54:00", updated_at: "2011-01-07 16:54:00">
#<Storeloc id: 320, site_id: 22, name: "refrigerated food item", number: 2, created_at: "2011-01-07 17:05:07", updated_at: "2011-01-07 17:05:07">
#<Storeloc id: 321, site_id: 22, name: "dry food item", number: 3, created_at: "2011-01-07 17:09:14", updated_at: "2011-01-07 17:09:14">
#<Storeloc id: 322, site_id: 22, name: "suply item", number: 4, created_at: "2011-01-07 17:13:43", updated_at: "2011-01-07 17:13:43">
#<Storeloc id: 291, site_id: 9, name: "Walk-in Freezer Commodity", number: 2, created_at: "2011-01-07 16:26:58", updated_at: "2011-01-07 16:26:58">
#<Storeloc id: 232, site_id: 21, name: "Storage Shed  #1/pantry", number: 0, created_at: "2010-12-16 20:01:10", updated_at: "2014-10-01 16:17:48">
#<Storeloc id: 308, site_id: 16, name: "chip room freezer", number: 1, created_at: "2011-01-07 16:31:09", updated_at: "2011-01-07 16:31:09">
#<Storeloc id: 249, site_id: 14, name: "Freezer", number: 0, created_at: "2011-01-07 16:24:32", updated_at: "2011-01-07 16:24:32">
#<Storeloc id: 247, site_id: 10, name: "Frozen items", number: 0, created_at: "2011-01-07 16:24:22", updated_at: "2011-01-07 16:24:22">
#<Storeloc id: 262, site_id: 14, name: "Walk In Cooler", number: 3, created_at: "2011-01-07 16:25:18", updated_at: "2011-01-07 16:25:18">
#<Storeloc id: 271, site_id: 14, name: "Kitchen", number: 4, created_at: "2011-01-07 16:25:36", updated_at: "2011-01-07 16:25:36">
#<Storeloc id: 282, site_id: 14, name: "Food Court Store Room", number: 5, created_at: "2011-01-07 16:26:06", updated_at: "2011-01-07 16:26:06">
#<Storeloc id: 289, site_id: 14, name: "Food Court ", number: 6, created_at: "2011-01-07 16:26:38", updated_at: "2011-01-07 16:26:38">
#<Storeloc id: 220, site_id: 47, name: "Kitchen Warehouse Pantry", number: 9, created_at: "2010-12-15 19:30:22", updated_at: "2010-12-15 19:56:05">
#<Storeloc id: 213, site_id: 47, name: "Main Warehouse Supplies Area 3", number: 1, created_at: "2010-12-14 17:02:20", updated_at: "2014-07-02 15:27:52">
#<Storeloc id: 226, site_id: 47, name: "Kitchen Refrigerator #6 Production", number: 8, created_at: "2010-12-15 19:33:59", updated_at: "2010-12-15 19:53:37">
#<Storeloc id: 211, site_id: 47, name: "Main Warehouse Dry Food", number: 0, created_at: "2010-12-14 17:01:54", updated_at: "2010-12-15 19:50:05">
#<Storeloc id: 231, site_id: 47, name: "Back Warehouse Area 2", number: 3, created_at: "2010-12-15 19:57:50", updated_at: "2014-07-02 15:29:54">
#<Storeloc id: 243, site_id: 16, name: "Walk in fridg", number: 2, created_at: "2011-01-07 16:24:09", updated_at: "2011-01-07 16:24:09">
#<Storeloc id: 264, site_id: 16, name: "Chip room", number: 3, created_at: "2011-01-07 16:25:18", updated_at: "2011-01-07 16:25:18">
#<Storeloc id: 272, site_id: 16, name: "pantry", number: 4, created_at: "2011-01-07 16:25:37", updated_at: "2011-01-07 16:25:37">
#<Storeloc id: 279, site_id: 16, name: "store room", number: 5, created_at: "2011-01-07 16:25:59", updated_at: "2011-01-07 16:25:59">
#<Storeloc id: 210, site_id: 47, name: "Main Warehouse Freezer #8", number: 4, created_at: "2010-12-14 17:01:27", updated_at: "2010-12-15 19:25:51">
#<Storeloc id: 260, site_id: 10, name: "refrigerated items", number: 1, created_at: "2011-01-07 16:25:16", updated_at: "2011-01-07 16:25:16">
#<Storeloc id: 273, site_id: 10, name: "pantry", number: 2, created_at: "2011-01-07 16:25:42", updated_at: "2011-01-07 16:25:42">
#<Storeloc id: 283, site_id: 10, name: "paper goods", number: 3, created_at: "2011-01-07 16:26:07", updated_at: "2011-01-07 16:26:07">
#<Storeloc id: 227, site_id: 47, name: "Kitchen Freezer #7 ", number: 7, created_at: "2010-12-15 19:34:20", updated_at: "2010-12-15 19:54:18">
#<Storeloc id: 294, site_id: 9, name: "Walk-in Freezer ", number: 1, created_at: "2011-01-07 16:27:17", updated_at: "2013-11-19 18:39:53">
#<Storeloc id: 270, site_id: 9, name: "Storage Shed", number: 4, created_at: "2011-01-07 16:25:31", updated_at: "2011-01-07 16:25:31">
#<Storeloc id: 263, site_id: 9, name: "Walk-in Refer", number: 5, created_at: "2011-01-07 16:25:18", updated_at: "2011-01-07 16:25:18">
#<Storeloc id: 252, site_id: 9, name: "Teacher's Reach-in Refer", number: 6, created_at: "2011-01-07 16:24:41", updated_at: "2011-01-07 16:24:41">
#<Storeloc id: 244, site_id: 9, name: "Speedline Room/Refer", number: 7, created_at: "2011-01-07 16:24:11", updated_at: "2011-01-07 16:29:40">
#<Storeloc id: 178, site_id: 23, name: "Warehouse Order Dry Goods", number: 0, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 239, site_id: 9, name: "Office/ Pantry", number: 0, created_at: "2011-01-07 16:23:18", updated_at: "2011-01-07 16:30:27">
#<Storeloc id: 286, site_id: 9, name: "Storage Room", number: 3, created_at: "2011-01-07 16:26:20", updated_at: "2011-01-07 16:26:20">
#<Storeloc id: 179, site_id: 23, name: "Warehouse Order Frozen", number: 1, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 180, site_id: 23, name: "Frozen Food Items", number: 2, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 181, site_id: 23, name: "Refrigerated Food Items", number: 3, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 182, site_id: 23, name: "Dry Food Items", number: 4, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 183, site_id: 23, name: "Supply Items", number: 5, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 184, site_id: 23, name: "Warehouse Order Supplies", number: 6, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 185, site_id: 23, name: "Government Comodity Dry", number: 7, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 186, site_id: 23, name: "Government Comodity Frozen", number: 8, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 187, site_id: 23, name: "Plastic Wrap and Containers", number: 9, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 177, site_id: 23, name: "DFC Paper Goods", number: 10, created_at: "2010-08-16 17:25:20", updated_at: "2013-11-21 21:16:09">
#<Storeloc id: 254, site_id: 16, name: "walk in freezer", number: 0, created_at: "2011-01-07 16:24:55", updated_at: "2011-01-07 16:24:55">
#<Storeloc id: 241, site_id: 14, name: "Store Room", number: 2, created_at: "2011-01-07 16:23:49", updated_at: "2011-01-07 16:23:49">
#<Storeloc id: 48, site_id: 18, name: "Frozen Food Items", number: 2, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 49, site_id: 18, name: "Refrigerated Food Items", number: 3, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 53, site_id: 18, name: "Government Comodity Dry", number: 4, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 54, site_id: 18, name: "Government Comodity Frozen", number: 5, created_at: "2010-08-16 17:25:20", updated_at: "2010-08-16 17:25:20">
#<Storeloc id: 251, site_id: 1, name: "INSIDE FREEZER", number: 4, created_at: "2011-01-07 16:24:39", updated_at: "2011-01-07 16:24:39">
#<Storeloc id: 258, site_id: 1, name: "WALK IN 1 & 2", number: 5, created_at: "2011-01-07 16:25:06", updated_at: "2011-03-01 18:23:56">
#<Storeloc id: 257, site_id: 15, name: "pantry", number: 0, created_at: "2011-01-07 16:25:01", updated_at: "2011-01-07 16:46:29">
#<Storeloc id: 267, site_id: 15, name: "storage shed 2", number: 1, created_at: "2011-01-07 16:25:27", updated_at: "2011-01-07 16:25:27">
#<Storeloc id: 240, site_id: 15, name: "freezer", number: 2, created_at: "2011-01-07 16:23:21", updated_at: "2011-01-07 16:23:21">
#<Storeloc id: 245, site_id: 15, name: "refrigerator", number: 3, created_at: "2011-01-07 16:24:17", updated_at: "2011-01-07 16:24:17">
#<Storeloc id: 250, site_id: 15, name: "storage shed", number: 4, created_at: "2011-01-07 16:24:38", updated_at: "2011-01-07 16:46:05">
#<Storeloc id: 336, site_id: 19, name: "Shed", number: 0, created_at: "2011-02-01 16:10:28", updated_at: "2011-02-01 16:10:28">
#<Storeloc id: 338, site_id: 19, name: "Chemical area/Main Kitchen", number: 1, created_at: "2011-05-02 16:14:11", updated_at: "2011-05-06 16:17:24">
#<Storeloc id: 256, site_id: 19, name: "walkin freezer", number: 2, created_at: "2011-01-07 16:24:59", updated_at: "2011-01-07 16:24:59">
#<Storeloc id: 330, site_id: 19, name: "walk in fridge", number: 3, created_at: "2011-01-11 16:14:04", updated_at: "2011-01-11 16:14:04">
#<Storeloc id: 274, site_id: 19, name: "2 doors freezer", number: 4, created_at: "2011-01-07 16:25:44", updated_at: "2011-01-07 16:25:44">
#<Storeloc id: 287, site_id: 19, name: "pantry", number: 5, created_at: "2011-01-07 16:26:24", updated_at: "2011-01-07 16:26:24">
#<Storeloc id: 284, site_id: 19, name: "store room", number: 6, created_at: "2011-01-07 16:26:09", updated_at: "2011-01-07 16:26:09">
#<Storeloc id: 315, site_id: 22, name: "dfc order", number: 0, created_at: "2011-01-07 16:52:17", updated_at: "2011-01-07 16:52:17">
#<Storeloc id: 343, site_id: 47, name: "Loading Dock Area 1", number: 2, created_at: "2012-06-08 16:18:13", updated_at: "2014-07-02 15:28:21">
#<Storeloc id: 89, site_id: 8, name: "Paper Goods/DFC Sply", number: nil, created_at: "2010-08-16 17:25:20", updated_at: "2016-04-19 18:47:28">
#<Storeloc id: 316, site_id: 3, name: "Frozen", number: 0, created_at: "2011-01-07 16:52:55", updated_at: "2016-04-27 20:06:43">
#<Storeloc id: 327, site_id: 3, name: "Dairy", number: 1, created_at: "2011-01-07 17:39:25", updated_at: "2016-04-27 20:07:33">
#<Storeloc id: 341, site_id: 47, name: "East Freezer", number: 5, created_at: "2012-04-10 15:39:20", updated_at: "2012-04-10 15:39:20">
#<Storeloc id: 342, site_id: 47, name: "West Freezer", number: 6, created_at: "2012-04-10 15:47:34", updated_at: "2012-04-10 15:47:34">
#<Storeloc id: 347, site_id: 47, name: "Oxford Freezer", number: 10, created_at: "2013-07-02 20:01:57", updated_at: "2013-07-02 20:01:57">
#<Storeloc id: 349, site_id: 47, name: "Filing Cabinet - Brians Office", number: nil, created_at: "2014-07-02 18:10:48", updated_at: "2014-07-02 18:10:48">
#<Storeloc id: 285, site_id: 20, name: "Freezer", number: 2, created_at: "2011-01-07 16:26:14", updated_at: "2012-11-02 21:19:10">
#<Storeloc id: 350, site_id: 4, name: "Walkin Freezer", number: 0, created_at: "2014-08-28 13:47:01", updated_at: "2014-08-28 13:47:01">
#<Storeloc id: 307, site_id: 4, name: "Paper Goods", number: 1, created_at: "2011-01-07 16:30:01", updated_at: "2011-01-07 16:30:01">
#<Storeloc id: 303, site_id: 4, name: "Walk-in Refrigerator", number: 2, created_at: "2011-01-07 16:28:37", updated_at: "2011-01-07 16:28:37">
#<Storeloc id: 268, site_id: 4, name: "Pantry", number: 3, created_at: "2011-01-07 16:25:29", updated_at: "2011-01-07 16:25:29">
#<Storeloc id: 353, site_id: 12, name: "Pantry", number: 0, created_at: "2014-10-09 15:58:32", updated_at: "2014-10-09 15:58:32">
#<Storeloc id: 354, site_id: 12, name: "Freezer", number: 1, created_at: "2014-10-09 15:58:56", updated_at: "2014-10-09 15:58:56">
#<Storeloc id: 355, site_id: 12, name: "Walk-in Fridge", number: 2, created_at: "2014-10-09 15:59:07", updated_at: "2014-10-09 15:59:07">
#<Storeloc id: 356, site_id: 18, name: "Dry Paper goods ", number: nil, created_at: "2016-04-13 21:19:00", updated_at: "2016-04-13 21:19:00">
#<Storeloc id: 357, site_id: 20, name: "Pantry", number: nil, created_at: "2016-04-14 14:06:57", updated_at: "2016-04-14 14:06:57">
#<Storeloc id: 261, site_id: 20, name: "Dry Storage", number: 3, created_at: "2011-01-07 16:25:18", updated_at: "2016-04-14 14:07:25">
#<Storeloc id: 358, site_id: 20, name: "Walk in fridge", number: nil, created_at: "2016-04-18 17:40:10", updated_at: "2016-04-18 17:40:10">
#<Storeloc id: 359, site_id: 13, name: "walk in Freezer", number: nil, created_at: "2016-04-18 20:26:30", updated_at: "2016-04-18 20:26:30">
#<Storeloc id: 361, site_id: 13, name: "Front Pantry Dry Storage", number: nil, created_at: "2016-04-20 17:18:56", updated_at: "2016-04-20 17:18:56">
#<Storeloc id: 362, site_id: 3, name: "Bread", number: nil, created_at: "2016-04-27 20:08:20", updated_at: "2016-04-27 20:08:20">
#<Storeloc id: 363, site_id: 3, name: "Dry", number: nil, created_at: "2016-04-27 20:08:27", updated_at: "2016-04-27 20:08:27">
#<Storeloc id: 364, site_id: 3, name: "Paper", number: nil, created_at: "2016-04-27 20:08:34", updated_at: "2016-04-27 20:08:34">
#<Storeloc id: 365, site_id: 3, name: "Produce", number: nil, created_at: "2016-04-27 20:08:55", updated_at: "2016-04-27 20:08:55">
#<Storeloc id: 366, site_id: 3, name: "Freezie", number: nil, created_at: "2016-04-27 20:09:06", updated_at: "2016-04-27 20:09:06">
#<Storeloc id: 367, site_id: 47, name: "West Freezer - OUTSIDE", number: nil, created_at: "2016-07-06 15:52:47", updated_at: "2016-07-06 15:52:47">
#<Storeloc id: 368, site_id: 47, name: "East Freezer - OUTSIDE", number: nil, created_at: "2016-07-06 16:03:11", updated_at: "2016-07-06 16:03:11">
#<Storeloc id: 369, site_id: 17, name: "Produce", number: nil, created_at: "2016-10-27 17:02:22", updated_at: "2016-10-27 17:02:22">
#<Storeloc id: 370, site_id: 17, name: "Paper", number: nil, created_at: "2016-10-27 17:04:02", updated_at: "2016-10-27 17:04:02">
#<Storeloc id: 371, site_id: 17, name: "Dry", number: nil, created_at: "2016-10-27 17:04:09", updated_at: "2016-10-27 17:04:09">
#<Storeloc id: 372, site_id: 17, name: "Frozen", number: nil, created_at: "2016-10-27 17:04:18", updated_at: "2016-10-27 17:04:18">
