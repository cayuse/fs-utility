class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :contact
      t.string :addr1
      t.string :addr2
      t.string :city
      t.string :st
      t.integer :zip
      t.string :phone1
      t.string :phone2
      t.string :fax
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
