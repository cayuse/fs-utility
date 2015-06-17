pdf.font("Courier", :size => 8)
pdf.text "\
Anaheim Union High School District            #{@weeklydfcorder.site.name}
Weekly Order Confirmation                     Generated: #{Time.now}

"
pdf.font("Courier", :style=> :bold, :size => 12)
pdf.text "For Week of: #{@weeklydfcorder.weeklyorderreq.week.strftime('%b %d, %Y')}

"
days_item_table(pdf, @data)