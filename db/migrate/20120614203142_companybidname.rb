class Companybidname < ActiveRecord::Migration
  def self.up
    create_table :companybidnames do |t|
      t.integer :company_id
      t.integer :bidname_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companybidnames
  end
end