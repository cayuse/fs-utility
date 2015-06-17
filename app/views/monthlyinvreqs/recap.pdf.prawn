@prawn_document_options = {:page_layout=>:landscape}
pdf.font("Courier", :size => 10)
pdf.text "\
                                          ANAHEIM UNION HIGH SCHOOL DISTRICT"
pdf.text @date.strftime("\
District Recap                                  Food Service Inventory                                  %B %Y")


totals = []
data = []
@monthlyinvreqs.sort.each do |req|
    thisdata = []
    req.monthlyinvs.sort.each do |inv|
        a        = inv.site.name
#            inv.monthlyinvitems.each do |itm|
#                unless itm.item.price_on_date(@date).cost
#                    debugger
#                    1
#                    1
#                end
#            end
        food     = inv.monthlyinvitems.inject(0){|i, itm| Monthlyinvreq::FOOD.include?(itm.item.itemtype_id) ? i + (itm.price.cost * itm.qty) : i }
        govt     = inv.monthlyinvitems.inject(0){|i, itm| Monthlyinvreq::GOVT_FOOD.include?(itm.item.itemtype_id) ? i + (itm.price.cost * itm.qty) : i }
        tot_food = food + govt
        supply   = inv.monthlyinvitems.inject(0){|i, itm| Monthlyinvreq::SUPPLY.include?(itm.item.itemtype_id) ? i + (itm.price.cost * itm.qty) : i }
        total_inv = tot_food + supply
        fmv      = inv.monthlyinvitems.inject(0){|i, itm| i + (itm.price.fmv * itm.qty)}
        data.push([a, food, govt, tot_food, supply, total_inv, fmv])
        thisdata.push([a, food, govt, tot_food, supply, total_inv, fmv])
    end
    subtotal = [ "Subtotal",
                  thisdata.map{|a| a[1]}.sum,
                  thisdata.map{|a| a[2]}.sum,
                  thisdata.map{|a| a[3]}.sum,
                  thisdata.map{|a| a[4]}.sum,
                  thisdata.map{|a| a[5]}.sum,
                  thisdata.map{|a| a[6]}.sum ]
    if req.monthlyinvs.length >= 1
        data.push subtotal if req.monthlyinvs.length > 1
    end
    totals.push(subtotal)
end

grandtotal = [ "Grand Total",
              totals.map{|a| a[1]}.sum,
              totals.map{|a| a[2]}.sum,
              totals.map{|a| a[3]}.sum,
              totals.map{|a| a[4]}.sum,
              totals.map{|a| a[5]}.sum,
              totals.map{|a| a[6]}.sum ]
data.push(grandtotal)
data.each do |entry|
    entry.each_with_index do |ent, idx|
        entry[idx] = number_to_currency(ent) if idx > 0
    end
end
district_recap_table(pdf, data)
