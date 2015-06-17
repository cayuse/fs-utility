class Bidname < ActiveRecord::Base
  has_many :companybidnames
  has_many :companies, :through => :companybidnames


  def xls
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet

    sheet1.row(0).replace ["Company Name", "Contact", "Address 1", "Address 2",
                           "City", "ST", "Zip", "Phone 1",
                           "Phone 2", "Fax", "E-Mail"]

    self.companies.each_with_index do |company, idx|
      sheet1.row(idx + 1).replace [company.name, company.contact, company.addr1, company.addr2,
                                   company.city, company.st, company.zip, company.phone1,
                                   company.phone2, company.fax, company.email]
    end
    sheet1.column(0).width = 30
    sheet1.column(1).width = 22
    sheet1.column(2).width = 33
    sheet1.column(3).width = 15
    sheet1.column(4).width = 17
    sheet1.column(5).width = 4
    sheet1.column(6).width = 6
    sheet1.column(7).width = 17
    sheet1.column(8).width = 17
    sheet1.column(9).width = 17
    sheet1.column(10).width = 30

    buffer = StringIO.new
    book.write(buffer)
    #buffer.rewind
    buffer.string
  end

end
