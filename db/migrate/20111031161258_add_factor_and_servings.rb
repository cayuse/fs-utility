class AddFactorAndServings < ActiveRecord::Migration
  def self.up
    add_column :nutritionals, :factor,    :string
    add_column :nutritionals, :servings,  :string
  end

  def self.down
    remove_column :nutritionals, :factor
    remove_column :nutritionals, :servings
  end
end
