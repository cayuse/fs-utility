class ReportDrawer

  require 'action_view'
  extend ActionView::Helpers::NumberHelper
  
  
  def self.separate_with_site_breakdown(date, items, days)
    date = date.monday

    data = []
    days.each do |i|
      data[i] = {}
      hash = {}
      items.each do |obj|
        if (obj.send(Orderitem::QTYS[i]) > 0)
          # Each element in the data will have:
          # index0 => Description string
          # index1 => An Array of Hashes with {:site_name => qty}
          hash[obj.item] ||= []
          qty = obj.send(Orderitem::QTYS[i])
          hash[obj.item].push([obj.weeklydfcorder.site.name, qty])
        end
        hash[obj.item].sort! if hash[obj.item]
      end

      if !hash.empty?
        data[i] = hash
        #add up the total quantity
        data[i].keys.each do |itm|
          totqty = data[i][itm].inject(0){|a,b| a + b[1].to_f}
          #add up the total value
          data[i][itm] << ["Total", number_with_delimiter(totqty)]
          #last = data[type].map
        end
      end
    end
    return data
  end

  def self.combined_totals(date, items)
      date = date.monday
      data = {}
      Itemtype.all.each do |type|
          hash = {}
          items.each do |obj|
              if (obj.item.itemtype == type)
                  # Each element in the data will have:
                  # index0 => Description string
                  # index1 => A hash for quantity with :value and :text
                  # index2 => A hash for value with :value and :text
                  hash[obj.item] ||= ["",{},{}]
                  hash[obj.item][0] = obj.item.name
                  #add to total quantity, Orderitem class takes care of nil for adds
                  hash[obj.item][1][:value] = hash[obj.item][1][:value].to_f + obj.allqty
                  #update total value add delimiting
                  hash[obj.item][1][:text] = number_with_delimiter(hash[obj.item][1][:value])
                  #add to total value have to check for nil value on outset
                  hash[obj.item][2][:value] = hash[obj.item][2][:value].to_f + obj.allcharge
                  #update total value in dollarized string format.
                  hash[obj.item][2][:text] = number_to_currency(hash[obj.item][2][:value])
              end
          end
          if !hash.values.empty?
              data[type] = hash.sort.map { |k,v| v }

              #add up the total quantity
              totqty = data[type].inject(0){|a,b| a + b[1][:value].to_f}
              #add up the total value
              totvalue = data[type].inject(0){|a,b| a + b[2][:value].to_f}
              #push the 3 onto the array with "Total" for text.
              data[type] << ["Total", number_with_delimiter(totqty), number_to_currency(totvalue)]
              #last = data[type].map
          end
      end
    return data
  end

  def self.separate_by_day(date, items, days)
    date = date.monday
    data = []

    days.each do |i|
      data[i] = {}
      data[i][:grand_totals]= {:qty=>0, :price=>0,}
      Itemtype.all.each do |type|
        hash = {}
        items.each do |obj|
          if (obj.item.itemtype == type) && (obj.send(Orderitem::QTYS[i]) > 0)
            # Each element in the data will have:
            # index0 => Description string
            # index1 => A hash for quantity with :value and :text
            # index2 => A hash for value with :value and :text
            hash[obj.item] ||= ["",{},{}]
            hash[obj.item][0] = obj.item.name
            #add to total quantity, Orderitem class takes care of nil for adds
            hash[obj.item][1][:value] = hash[obj.item][1][:value].to_f + obj.send(Orderitem::QTYS[i])
            #update total value add delimiting
            hash[obj.item][1][:text] = number_with_delimiter(hash[obj.item][1][:value])
            #add to total value have to check for nil value on outset
            hash[obj.item][2][:value] = hash[obj.item][2][:value].to_f + obj.send(Orderitem::CHARGES[i])
            #update total value in dollarized string format.
            hash[obj.item][2][:text] = number_to_currency(hash[obj.item][2][:value])
          end
        end
        if !hash.values.empty?
          data[i][type] = hash.sort.map { |k,v| v }
          #add up the total quantity
          totqty = data[i][type].inject(0){|a,b| a + b[1][:value].to_f}
          #add up the total value
          totvalue = data[i][type].inject(0){|a,b| a + b[2][:value].to_f}
          #push the 3 onto the array with "Total" for text.
          data[i][:grand_totals][:qty] += totqty
          data[i][:grand_totals][:total_quantity] = number_with_delimiter(data[i][:grand_totals][:qty])
          data[i][:grand_totals][:price] += totvalue
          data[i][:grand_totals][:total_price] = number_to_currency(data[i][:grand_totals][:price])
          data[i][type] << ["Total", number_with_delimiter(totqty), number_to_currency(totvalue)]
          #last = data[type].map
        end
      end
    end
    return data
  end


### This table will generate Food Service Inventory Recap
#  def self.district_recap_table(pdf, data)
#    if data.empty?
#      data = [["No Data", 0,0,0,0,0,0]]
#    end
#    pdf.table data,
#      :font               => "Courier",
#      :font_size          => 8,
#      :position           => [10, 20],
#      :headers            => ["Location", "Food", "Govt.", "Total Food", "Supply", "Total Inv", "Fair Market"],
#      :column_widths      => { 0 => 175, 1 => 90, 2 => 90, 3 => 90, 4 => 90, 5 => 90, 6 => 90 },
#      :align              => {0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right, 5 => :right, 6 => :right},
#      :row_colors         => ["ffffff","CCCCCC"],
#      :vertical_padding   => 5,
#      :horizontal_padding => 3
#  end
#
#
### This Table will genererate daily items broken down by sites
## Headers: "Item Description", "Quantity", "Charges"
#  def self.days_sites_item_table(pdf, data)
#    if data.empty?
#      data = [["No Data", 0,0]]
#    end
#    pdf.table data,
#      :font               => "Courier",
#      :font_size          => 12,
#      :position           => [10, 20],
#      :headers            => ["Site", "Quantity"],
#      :column_widths      => { 0=>300, 1=>70},
#      :row_colors         => ["ffffff","CCCCCC"],
#      :vertical_padding   => 5,
#      :align              => {0 => :left, 1 => :right},
#      :horizontal_padding => 3
#  end

## This table generator displays info about an individual item
# Headers: "Item Description", "Quantity", "Charges"
#  def self.item_table(pdf, data)
#    if data.empty?
#      data = [["No Data", 0,0]]
#    end
#    pdf.table data,
#      :font               => "Courier",
#      :font_size          => 12,
#      :position           => [10, 20],
#      :headers            => ["Item Description", "Quantity", "Charges"],
#      :column_widths      => { 0=>300, 1=>75, 2=>125 },
#      :row_colors         => ["ffffff","CCCCCC"],
#      :vertical_padding   => 5,
#      :align              => {1 => :right, 2 => :right},
#      :horizontal_padding => 3
#  end

## This Table generator displays info for a week broken down by daya
## Headers: "Item Description", "Monday", "Teusday", "Wednesday", "Thursday", "Friday"
#  def self.days_item_table(pdf, data)
#    if data.empty?
#      data = [["No Data", 0,0,0,0,0]]
#    end
#    pdf.table data,
#      :font               => "Courier",
#      :font_size          => 12,
#      :position           => [10, 20],
#      :headers            => ["Item Description", "Mon", "Tue", "Wed", "Thu", "Fri"],
#      :column_widths      => { 0=>200, 1=>70, 2=>70, 3=>70, 4=>70, 5=>70 },
#      :row_colors         => ["ffffff","CCCCCC"],
#      :vertical_padding   => 5,
#      :horizontal_padding => 3
#  end
#
#  def self.inventory_report_table(pdf, data)
#    if data.empty?
#      data = [["No Data", 0,0]]
#    end
#    pdf.table data,
#      :font_size          => 12,
#      :position           => [10, 20],
#      :headers            => ["Description", "Units", "U/I", "Quantity"],
#      :column_widths      => { 0=>250, 1=>50, 2=>75, 3=>100},
#      :row_colors         => ["ffffff","CCCCCC"],
#      :vertical_padding   => 5,
#      :align              => {0 => :left, 1 => :left, 2 => :left, 3 => :right},
#      :horizontal_padding => 3
#  end
#
#  def self.inventory_worksheet_table(pdf, data)
#    if data.empty?
#      data = [["No Data", 0,0,0]]
#    end
#    pdf.table data,
#      :font_size          => 12,
#      :position           => [10, 20],
#      :headers            => ["Description", "Units", "U/I", "Quantity"],
#      :column_widths      => { 0=>250, 1=>50, 2=>75, 3=>100},
#      :row_colors         => ["ffffff","CCCCCC"],
#      :vertical_padding   => 5,
#      :align              => {0 => :left, 1 => :left, 2 => :left, 3 => :right},
#      :horizontal_padding => 3
#  end
#
#  def self.invoice(pdf, data)
#    if data.empty?
#      data = [["No Data", 0,0]]
#    end
#    pdf.table data,
#      :font_size          => 12,
#      :position           => [10, 20],
#      :headers            => ["Description", "Quantity", "Unit Cost", "Charges"],
#      :column_widths      => { 0=>200, 1=>100, 2=>100, 3=>100},
#      :row_colors         => ["ffffff","CCCCCC"],
#      :vertical_padding   => 5,
#      :align              => {0 => :left, 1 => :right, 2 => :right, 3 => :right},
#      :horizontal_padding => 3
#  end

end
