class CreateOrderitems < ActiveRecord::Migration
  def self.up
    create_table :orderitems do |t|
      t.references :weeklydfcorder
      t.references :item
      t.integer :monqty
      t.integer :tueqty
      t.integer :wedqty
      t.integer :thuqty
      t.integer :friqty

      t.timestamps
    end
  end

  def self.down
    drop_table :orderitems
  end
end
