class CreateMonthlyinvitems < ActiveRecord::Migration
  def self.up
    create_table :monthlyinvitems do |t|
      t.references :monthlyinv
      t.references :item
      t.float :qty

      t.timestamps
    end
  end

  def self.down
    drop_table :monthlyinvitems
  end
end
