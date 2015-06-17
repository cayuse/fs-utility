@items.each do |item|
  data = []
  pdf.text "#{item.name}
#{item.itemtype ? item.itemtype.name : "Undefined"}"
  item.prices.each do |price|
    data.push [item.units, item.issue, number_to_currency(price.cost), number_to_currency(price.price),
               number_to_currency(price.fmv), price.start, price.expire]
    
  end
  
  if data.empty?
    data = [["No Data", 0,0,0,0,0,0]]
  end
  pdf.table data,
    :font               => "Courier",
    :font_size          => 6,
    :position           => [10, 20],
    :headers            => ["Units", "Issue", "Cost", "Price", "FMV", "Start Date", "Expire Date"],
    :column_widths      => { 0 => 40, 1 => 40, 2 => 40, 3 => 40, 4 => 40, 5 => 90, 6 => 90 },
    :align              => {0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right, 5 => :right, 6 => :right},
    :row_colors         => ["ffffff","CCCCCC"],
    :vertical_padding   => 5,
    :horizontal_padding => 3

  pdf.text "
"
end

