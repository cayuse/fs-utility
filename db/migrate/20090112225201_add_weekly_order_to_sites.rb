class AddWeeklyOrderToSites < ActiveRecord::Migration
  def self.up
    add_column :sitetypes, :mon, :boolean
    add_column :sitetypes, :tue, :boolean
    add_column :sitetypes, :wed, :boolean
    add_column :sitetypes, :thu, :boolean
    add_column :sitetypes, :fri, :boolean
  end

  def self.down
    remove_column :sitetypes, :mon
    remove_column :sitetypes, :tue
    remove_column :sitetypes, :wed
    remove_column :sitetypes, :thu
    remove_column :sitetypes, :fri
  end
end
