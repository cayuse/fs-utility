class AddItemtypeToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :itemtype_id, :integer
  end

  def self.down
    remove_column :items, :itemtype_id
  end
end
