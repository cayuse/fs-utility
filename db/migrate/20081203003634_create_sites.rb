class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.integer :number
      t.string :name
      t.string :address
      t.string :city
      t.string :state, :limit=>2
      t.string :zip, :limit=>9
      t.string :phone
      t.references :user
      t.references :sitetype

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
