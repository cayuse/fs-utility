class CreateMonthlyinvreqs < ActiveRecord::Migration
  def self.up
    create_table :monthlyinvreqs do |t|
      t.references :sitetype
      t.date :month
      t.date :start
      t.date :due

      t.timestamps
    end
  end

  def self.down
    drop_table :monthlyinvreqs
  end
end
