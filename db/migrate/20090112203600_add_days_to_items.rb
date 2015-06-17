class AddDaysToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :mon, :boolean
    add_column :items, :tue, :boolean
    add_column :items, :wed, :boolean
    add_column :items, :thu, :boolean
    add_column :items, :fri, :boolean
  end

  def self.down
    remove_column :items, :mon
    remove_column :items, :tue
    remove_column :items, :wed
    remove_column :items, :thu
    remove_column :items, :fri
  end
end
