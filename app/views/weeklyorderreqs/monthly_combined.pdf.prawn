
#These constants come from the Orderitem Class, and are used to 'send' msgs
#to its instances for useful information.
dates = Orderitem::DATES
qtys  = Orderitem::QTYS
charges = Orderitem::CHARGES

#This should be guaranteed to define one whole month First to Last day
daterange = (@date..@date.end_of_month)

#Items on the report are separated by type
itemtypes =  @orderitems.map {|itm| itm.item.itemtype}.uniq.sort
#dates.each_with_index {|d,i| puts "Date = #{d}, Index = #{i}, QTY = #{qtys[i]}, itmdate #{a.send(d)}, itmqty = #{a.send(qtys[i])}"}

######## DISPLAY
pdf.font("Courier", :size => 8)
pdf.text \
%{Anaheim Union High School District              Generated:   #{Time.now}
Monthly Order Totals                            Month Of:    #{@date.strftime("%b-%Y")}
}########### End DISPLAY


totals = []
itemtypes.sort.each do |type|
  #init an hash for later use
  data  = {}
  grid = []
  #pull out the items for this itemtype
  items = @orderitems.select{ |itm| itm.item.itemtype == type }
  
  items.sort.each do |item|
    #the following will check the qty of 
    dates.each_with_index do |date,i|
      data[item.item] ||= [0,0]
      if daterange.include?(item.send(date))
        data[item.item][0] += item.send(qtys[i])
        data[item.item][1] += item.send(charges[i])
      end
    end
  end
  
  data.keys.sort.each do |item|
    grid.push ( [ item.name, number_with_delimiter(data[item][0]), number_to_currency(data[item][1]) ] )
  end
    #compile and output here
  subtotal = [
    data.values.map{|a| a[0]}.sum,
    data.values.map{|a| a[1]}.sum
  ]
  grid.push ([ "Subtotal", number_with_delimiter(subtotal[0]), number_to_currency(subtotal[1]) ])
  totals.push(subtotal)

pdf.text \
%{

#{type.name}

}

  item_table(pdf, grid)
  
end
pdf.font("Courier", :style=> :bold, :size => 12)
qty = totals.inject(0){|sum,ea| sum + ea[0]}
tot = totals.inject(0){|sum,ea| sum + ea[1]}
pdf.text \
%{


Grand Totals:  Quantity: #{number_with_delimiter(qty)}   Charges: #{number_to_currency(tot)}
}


