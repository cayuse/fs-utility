class AddPriceToMonthlyinvitem < ActiveRecord::Migration
  def self.up
    add_column :monthlyinvitems, :price_id, :integer
  end

  def self.down
    remove_column :monthlyinvitems, :price_id
  end
end
