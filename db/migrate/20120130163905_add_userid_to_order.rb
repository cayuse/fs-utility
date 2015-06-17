class AddUseridToOrder < ActiveRecord::Migration
  def self.up
    add_column :orderitems, :updated_by,    :string
  end

  def self.down
    remove_column :orderitems, :updated_by
  end
end
