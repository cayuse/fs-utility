class AddStorelocToMonthlyinvitem < ActiveRecord::Migration
  def self.up
    add_column :monthlyinvitems, :storeloc_id, :integer
  end

  def self.down
    remove_column :monthlyinvitems, :storeloc_id
  end
end
