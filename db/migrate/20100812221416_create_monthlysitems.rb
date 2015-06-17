class CreateMonthlysitems < ActiveRecord::Migration
  def self.up
    create_table :monthlysitems do |t|
      t.references :site
      t.references :item

      t.timestamps
    end
  end

  def self.down
    drop_table :monthlysitems
  end
end
