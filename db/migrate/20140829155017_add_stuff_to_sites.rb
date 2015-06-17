class AddStuffToSites < ActiveRecord::Migration
  def change
    add_column :sites, :nurse_name, :string
    add_column :sites, :nurse_email, :string
    add_column :sites, :nurse_phone, :string
  end
end
