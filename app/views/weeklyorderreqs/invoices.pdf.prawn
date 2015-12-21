chargs = Orderitem::CHARGES
qtys = Orderitem::QTYS
@orders.each do |weeklydfcorder|
    @days.each do |day|
        ordered     = weeklydfcorder.orderitems.reject { |b| b.send(qtys[day]) == 0 }
        next if ordered.empty?
        description = ordered.map{ |b| b.item.name }
        quantity    = ordered.map{ |b| b.send(qtys[day]) }
        price       = ordered.map{ |b| number_to_currency( b.price ) }
        totcharges = 0
        charges     = ordered.map{ |b| a = b.send(chargs[day]); totcharges += a.to_f; number_to_currency(a.to_f) }
        data = [description, quantity, price, charges].transpose
        data.push [
            "Totals",
            number_with_delimiter(quantity.sum),
            " ",
            number_to_currency(totcharges)
        ]

        pdf.font("Courier", :size => 12)
        pdf.text \
%{Anaheim Union High School District              Invoice No:  #{(weeklydfcorder.weeklyorderreq.week + day.days).strftime("#{weeklydfcorder.site.number}-%Y%m%d")}
District Food Center Invoice                    Generated:   #{Time.now}}
        pdf.font("Courier", :style=> :bold, :size => 12)
        pdf.text %{
Deliver to:    #{weeklydfcorder.site.name}
Delivery Date: #{(weeklydfcorder.weeklyorderreq.week + day.days).strftime('%A, %B %d, %Y')}
}
        pdf.font("Courier", :size => 12)
        invoice(pdf, data)
        pdf.start_new_page
    end
end
    
