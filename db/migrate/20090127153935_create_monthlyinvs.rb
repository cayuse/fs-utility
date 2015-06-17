class CreateMonthlyinvs < ActiveRecord::Migration
  def self.up
    create_table :monthlyinvs do |t|
      t.references :monthlyinvreq
      t.references :site

      t.timestamps
    end
  end

  def self.down
    drop_table :monthlyinvs
  end
end
