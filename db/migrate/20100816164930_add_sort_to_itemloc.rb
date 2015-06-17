class AddSortToItemloc < ActiveRecord::Migration
  def self.up
    add_column :itemlocs, :sort, :integer
  end

  def self.down
    remove_column :itemlocs, :sort
  end
end
