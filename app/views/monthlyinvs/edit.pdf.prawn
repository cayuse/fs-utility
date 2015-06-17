pdf.text "Monthly Inventory Worksheet for #{@monthlyinv.monthlyinvreq.month.strftime("%B-%y")}"
@storelocs.each_with_index do |loc, idx|
    pdf.text "#{loc.name}"
    names = @monthlyinv_hash[loc].map{|i| i.item.name}
    units = @monthlyinv_hash[loc].map{|i| i.item.units}
    issue = @monthlyinv_hash[loc].map{|i| i.item.issue}
    qtys  = @monthlyinv_hash[loc].map{|i| i.qty.to_f}
    qtys.each_with_index do |qty, idx|
        qtys[idx] = "" if qty == 0
    end
    data = [names, units, issue, qtys].transpose
    inventory_worksheet_table(pdf, data)
    pdf.start_new_page if idx < (@storelocs.length - 1)
end

if @monthlyinv_hash[:leftovers]
    pdf.start_new_page
    pdf.text "Items With Erased Location"
    names = @monthlyinv_hash[:leftovers].map{|i| i.item.name}
    units = @monthlyinv_hash[:leftovers].map{|i| i.item.units}
    issue = @monthlyinv_hash[:leftovers].map{|i| i.item.issue}
    qtys  = @monthlyinv_hash[:leftovers].map{|i| i.qty.to_f}
    qtys.each_with_index do |qty, idx|
        qtys[idx] = "" if qty == 0
    end
    data = [names, units, issue, qtys].transpose
    inventory_worksheet_table(pdf, data)
end
