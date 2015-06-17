class Additemtypecolor < ActiveRecord::Migration
  def self.up
    add_column :itemtypes, :colorcode, :string
  end

  def self.down
    remove_column :itemtypes, :colorcode
  end
end
