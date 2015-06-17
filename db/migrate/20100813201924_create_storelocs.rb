class CreateStorelocs < ActiveRecord::Migration
  def self.up
    create_table :storelocs do |t|
      t.references :site
      t.string :name
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :storelocs
  end
end
