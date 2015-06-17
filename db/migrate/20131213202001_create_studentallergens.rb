class CreateStudentallergens < ActiveRecord::Migration
  def self.up
    create_table :studentallergens do |t|
      t.references :student
      t.references :allergen

      t.timestamps
    end
  end

  def self.down
    drop_table :studentallergens
  end
end
