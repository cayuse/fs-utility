class CreateValues < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.integer :item_id
      t.date :start
      t.date :expire
      t.integer :price_in_cents
      t.integer :cost_in_cents

      t.timestamps
    end
  end

  def self.down
    drop_table :values
  end
end
