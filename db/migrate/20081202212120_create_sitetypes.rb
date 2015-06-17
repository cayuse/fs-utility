class CreateSitetypes < ActiveRecord::Migration
  def self.up
    create_table :sitetypes do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :sitetypes
  end
end
