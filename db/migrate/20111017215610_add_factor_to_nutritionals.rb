class AddFactorToNutritionals < ActiveRecord::Migration
  def self.up
    add_column :nutritionals, :factor,    :string
  end

  def self.down
    remove_column :nutritionals, :factor
  end
end
