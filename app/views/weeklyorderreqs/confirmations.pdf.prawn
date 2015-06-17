@orders.each_with_index do |weeklydfcorder, i|
    data = weeklydfcorder.orderitems.sort.collect{ |b| [b.item.name, b.monqty, b.tueqty, b.wedqty, b.thuqty, b.friqty]}
    pdf.font("Courier", :size => 12)
pdf.text "\
Anaheim Union High School District           #{weeklydfcorder.site.name}
Weekly Order Confirmation                    Generated: #{Time.now}
Order For Week of: #{weeklydfcorder.weeklyorderreq.week.strftime('%b %d, %Y')}"
    days_item_table(pdf, data)
    pdf.start_new_page if i < @orders.length - 1
end