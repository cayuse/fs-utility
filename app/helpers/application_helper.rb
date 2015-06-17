# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def cycle(first_value, *values)
    values.unshift(first_value)
    return Cycle.new(*values)
  end

  class Cycle
    def initialize(first_value, *values)
      @values = values.unshift(first_value)
      @index = 0
    end

    def to_s
      value = @values[@index].to_s
      @index = (@index + 1) % @values.size
      return value
    end
  end
# => {"user"=>0, "distadmin"=>1, "inventory"=>2, "intersession"=>3, "manager"=>4,
#     "accounting"=>5, "bidadmin"=>6, "biduser"=>7, "admin"=>8} 
  def canViewForUser(user)
    canView = {}
    
    return canView unless user
    
    #administration tab
    if ["admin"].include? user.role
      canView[:admin] = {}
    end
    
    #District Admin Tab
    if ["admin", "distadmin"].include? user.role
      canView[:distAdmin] = {}
    end
    
    #intersession tab
    if ["admin", "intersession"].include? user.role
      canView[:intersession] = {}
    end
    
    #Order System tab
    if ["admin", "distadmin", "manager", "inventory", "intersession", "accounting"].include? user.role
      canView[:orderSystem] = {}
    end
    
    #Inventory System Tab
    if ["admin", "distadmin", "inventory"].include? user.role
      canView[:inventory] = {}
    end
    
    #Documents Tab
    if ["admin", "distadmin", "inventory", "intersession", "manager"].include? user.role
      canView[:documents] = {}
      if ["admin", "distadmin"].include? user.role
        canView[:documents][:new] = true
      end
    end
    
    #Bid Information Tab
    if ["admin", "distadmin", "biduser"].include? user.role
      canView[:bidInfo] = {}
    end
    if ["admin", "distadmin"].include? user.role
      canView[:bidInfo][:admin] = true
    end
    return canView
  end
  
#  def separate_with_site_breakdown(date, items, days)
#    date = date.monday
#
#    data = []
#    days.each do |i|
#      data[i] = {}
#      hash = {}
#      items.each do |obj|
#        if (obj.send(Orderitem::QTYS[i]) > 0)
#          # Each element in the data will have:
#          # index0 => Description string
#          # index1 => An Array of Hashes with {:site_name => qty}
#          hash[obj.item] ||= []
#          qty = obj.send(Orderitem::QTYS[i])
#          hash[obj.item].push([obj.weeklydfcorder.site.name, qty])
#        end
#        hash[obj.item].sort! if hash[obj.item]
#      end
#
#      if !hash.empty?
#        data[i] = hash
#        #add up the total quantity
#        data[i].keys.each do |itm|
#          totqty = data[i][itm].inject(0){|a,b| a + b[1].to_f}
#          #add up the total value
#          data[i][itm] << ["Total", help.number_with_delimiter(totqty)]
#          #last = data[type].map
#        end
#      end
#    end
#    return data
#  end
#
#  def combined_totals(date, items)
#      date = date.monday
#      data = {}
#      Itemtype.all.each do |type|
#          hash = {}
#          items.each do |obj|
#              if (obj.item.itemtype == type)
#                  # Each element in the data will have:
#                  # index0 => Description string
#                  # index1 => A hash for quantity with :value and :text
#                  # index2 => A hash for value with :value and :text
#                  hash[obj.item] ||= ["",{},{}]
#                  hash[obj.item][0] = obj.item.name
#                  #add to total quantity, Orderitem class takes care of nil for adds
#                  hash[obj.item][1][:value] = hash[obj.item][1][:value].to_f + obj.allqty
#                  #update total value add delimiting
#                  hash[obj.item][1][:text] = help.number_with_delimiter(hash[obj.item][1][:value])
#                  #add to total value have to check for nil value on outset
#                  hash[obj.item][2][:value] = hash[obj.item][2][:value].to_f + obj.allcharge
#                  #update total value in dollarized string format.
#                  hash[obj.item][2][:text] = help.number_to_currency(hash[obj.item][2][:value])
#              end
#          end
#          if !hash.values.empty?
#              data[type] = hash.sort.map { |k,v| v }
#
#              #add up the total quantity
#              totqty = data[type].inject(0){|a,b| a + b[1][:value].to_f}
#              #add up the total value
#              totvalue = data[type].inject(0){|a,b| a + b[2][:value].to_f}
#              #push the 3 onto the array with "Total" for text.
#              data[type] << ["Total", help.number_with_delimiter(totqty), help.number_to_currency(totvalue)]
#              #last = data[type].map
#          end
#      end
#    return data
#  end
#
#  def separate_by_day(date, items, days)
#    date = date.monday
#
#    data = []
#
#    days.each do |i|
#      data[i] = {}
#      data[i][:grand_totals]= {:qty=>0, :price=>0,}
#      Itemtype.all.each do |type|
#        hash = {}
#        items.each do |obj|
#          if (obj.item.itemtype == type) && (obj.send(Orderitem::QTYS[i]) > 0)
#            # Each element in the data will have:
#            # index0 => Description string
#            # index1 => A hash for quantity with :value and :text
#            # index2 => A hash for value with :value and :text
#            hash[obj.item] ||= ["",{},{}]
#            hash[obj.item][0] = obj.item.name
#            #add to total quantity, Orderitem class takes care of nil for adds
#            hash[obj.item][1][:value] = hash[obj.item][1][:value].to_f + obj.send(Orderitem::QTYS[i])
#            #update total value add delimiting
#            hash[obj.item][1][:text] = help.number_with_delimiter(hash[obj.item][1][:value])
#            #add to total value have to check for nil value on outset
#            hash[obj.item][2][:value] = hash[obj.item][2][:value].to_f + obj.send(Orderitem::CHARGES[i])
#            #update total value in dollarized string format.
#            hash[obj.item][2][:text] = help.number_to_currency(hash[obj.item][2][:value])
#          end
#        end
#        if !hash.values.empty?
#          data[i][type] = hash.sort.map { |k,v| v }
#          #add up the total quantity
#          totqty = data[i][type].inject(0){|a,b| a + b[1][:value].to_f}
#          #add up the total value
#          totvalue = data[i][type].inject(0){|a,b| a + b[2][:value].to_f}
#          #push the 3 onto the array with "Total" for text.
#          data[i][:grand_totals][:qty] += totqty
#          data[i][:grand_totals][:total_quantity] = help.number_with_delimiter(data[i][:grand_totals][:qty])
#          data[i][:grand_totals][:price] += totvalue
#          data[i][:grand_totals][:total_price] = help.number_to_currency(data[i][:grand_totals][:price])
#          data[i][type] << ["Total", help.number_with_delimiter(totqty), help.number_to_currency(totvalue)]
#          #last = data[type].map
#        end
#      end
#    end
#    return data
#  end



## This table will generate Food Service Inventory Recap
  def district_recap_table(pdf, data)
    if data.empty?
      data = [["No Data", 0,0,0,0,0,0]]
    end
    data.unshift(["Location", "Food", "Govt.", "Total Food", "Supply", "Total Inv", "Fair Market"])
    pdf.table(data,
      :column_widths      => { 0 => 175, 1 => 90, 2 => 90, 3 => 90, 4 => 90, 5 => 90, 6 => 90 },
      :row_colors         => ["ffffff","CCCCCC"]
      ) do
        row(0).style :align => :center
        column(0).style :align => :left
        column(1).style :align => :right
        column(2).style :align => :right
        column(3).style :align => :right
        column(4).style :align => :right
        column(5).style :align => :right
        column(6).style :align => :right
      end
  end

## This Table will genererate daily items broken down by sites
# Headers: "Item Description", "Quantity", "Charges"
  def days_sites_item_table(pdf, data)
    if data.empty?
      data = [["No Data", 0,0]]
    end
    data.unshift(["Site", "Quantity"])
    pdf.table(data,
      :column_widths      => { 0=>300, 1=>70},
      :row_colors         => ["ffffff","CCCCCC"]
      ) do
          row(0).style :align => :center 
          column(0).style :align => :left 
          column(1).style :align => :right 
    end
  end

## This table generator displays info about an individual item
# Headers: "Item Description", "Quantity", "Charges"

  def item_table(pdf, data)
    if data.empty?
      data = [["No Data", 0,0]]
    end
    data.unshift(["Item Description", "Quantity", "Charges"])
    pdf.table data,
      :column_widths      => { 0=>300, 1=>75, 2=>125 },
      :row_colors         => ["ffffff","CCCCCC"]
  end

## This Table generator displays info for a week broken down by daya
# Headers: "Item Description", "Monday", "Teusday", "Wednesday", "Thursday", "Friday"
  def days_item_table(pdf, data)
    if data.empty?
      data = [["No Data", 0,0,0,0,0]]
    end
    data.unshift(["Item Description", "Mon", "Tue", "Wed", "Thu", "Fri"])
    pdf.table data,
      :column_widths      => { 0=>200, 1=>60, 2=>60, 3=>60, 4=>60, 5=>60 },
      :row_colors         => ["ffffff","CCCCCC"]
  end

  def inventory_report_table(pdf, data)
    if data.empty?
      data = [["No Data", 0,0]]
    end
    data.unshift(["Description", "Units", "U/I", "Quantity"])
    pdf.table(data,
      :column_widths      => { 0=>250, 1=>50, 2=>75, 3=>100},
      :row_colors         => ["ffffff","CCCCCC"]
      ) do
          row(0).style :align => :center 
          column(0).style :align => :left 
          column(1).style :align => :left 
          column(2).style :align => :left
          column(3).style :align => :right
    end
  end

  def inventory_worksheet_table(pdf, data)
    if data.empty?
      data = [["No Data", 0,0,0]]
    end
    data.unshift(["Description", "Units", "U/I", "Quantity"])
    pdf.table(data,
      :column_widths      => { 0=>250, 1=>50, 2=>75, 3=>100},
      :row_colors         => ["ffffff","CCCCCC"]
        ) do
          row(0).style :align => :center 
          column(0).style :align => :left 
          column(1).style :align => :left 
          column(2).style :align => :left
          column(3).style :align => :right
    end
  end

  def invoice(pdf, data)
    if data.empty?
      data = [["No Data", 0,0]]
    end
    data.unshift(["Description", "Quantity", "Unit Cost", "Charges"])
    pdf.table(data,
      :column_widths      => { 0=>200, 1=>100, 2=>100, 3=>100},
      :row_colors         => ["ffffff","CCCCCC"]
        ) do
          row(0).style :align => :center 
          column(0).style :align => :right 
          column(1).style :align => :right 
          column(2).style :align => :right
          column(3).style :align => :left
    end
  end
end
