class CreateBidnames < ActiveRecord::Migration
  def self.up
    create_table :bidnames do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :bidnames
  end
end
