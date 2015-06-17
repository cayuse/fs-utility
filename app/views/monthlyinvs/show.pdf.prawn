pdf.text @monthlyinv.monthlyinvreq.month.strftime("#{@monthlyinv.site.name}   %B, %Y Inventory")

allitems = @monthlyinv.monthlyinvitems.sort
types = @monthlyinv.monthlyinvitems.collect{|c| c.item.itemtype}.uniq
types.sort!
types.each do |type|
    theseitems = allitems.select{|item| item.item.itemtype == type}
    data = theseitems.map{|i| [i.item.name, i.item.units, i.item.issue, i.qty]}
    pdf.text ("\n\n#{type.name}\n\n")
    inventory_report_table(pdf, data) unless data.empty?
end
