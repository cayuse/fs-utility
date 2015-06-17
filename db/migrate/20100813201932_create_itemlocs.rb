class CreateItemlocs < ActiveRecord::Migration
  def self.up
    create_table :itemlocs do |t|
      t.references :storeloc
      t.references :item

      t.timestamps
    end
  end

  def self.down
    drop_table :itemlocs
  end
end
