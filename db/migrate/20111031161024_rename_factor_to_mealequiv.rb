class RenameFactorToMealequiv < ActiveRecord::Migration
  def self.up
    rename_column :nutritionals, :factor, :mealequiv
  end

  def self.down
    rename_column :nutritionals, :mealequiv, :factor
  end
end
