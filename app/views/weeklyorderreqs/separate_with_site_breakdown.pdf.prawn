@days.each do |i|
date = @date + i.days
      @data[i].keys.each do |item|
            pdf.font("Courier", :size => 12)
            pdf.text \
"Anaheim Union High School District           Generated: #{Time.now}
Daily Food Center Order For:"
            pdf.font("Courier", :style=> :bold, :size => 12)
            pdf.text "#{(date).strftime("%A %b %d, %Y")}"
            pdf.font("Courier", :style=> :bold, :size => 16)
            pdf.text "\n#{item.name}", :align => :right
            pdf.text "\n", :align => :left
            pdf.font("Courier", :size => 12)
            days_sites_item_table(pdf, @data[i][item])
            pdf.start_new_page
      end
end
