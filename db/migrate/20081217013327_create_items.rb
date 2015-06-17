class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.integer :units
      t.string :issue
      t.integer :sort

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
