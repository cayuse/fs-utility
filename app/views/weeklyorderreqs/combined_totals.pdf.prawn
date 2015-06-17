pdf.font("Courier", :size => 12)
  pdf.text "Anaheim Union High School District
Generated: #{Time.now}
"
  pdf.font("Courier", :style=> :bold, :size => 12)
  pdf.text "Weekly Food Center Order For Week of: #{@date.strftime('%b %d, %Y')}

"
  
for type in @data.keys.sort
  pdf.font("Courier", :style=> :bold, :size => 12)
  pdf.text "\n#{type.name}\n"
  
  pdf.font("Courier", :size => 12)

  my_array = []
  @data[type].each do |thing|
    if thing[1].is_a? Hash
      my_array.push [ thing[0], thing[1][:text], thing[2][:text] ]
    else
      my_array.push thing
    end
  end  
  item_table(pdf, my_array)
end
