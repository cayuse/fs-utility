class CreateItemallergens < ActiveRecord::Migration
  def self.up
    create_table :itemallergens do |t|
      t.references :item
      t.references :allergen

      t.timestamps
    end
  end

  def self.down
    drop_table :itemallergens
  end
end
