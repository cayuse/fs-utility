class AddReferencesToNutritional < ActiveRecord::Migration
  def self.up
    add_column :nutritionals, :foodvendor_id,    :integer
  end

  def self.down
    remove_column :nutritionals, :foodvendor_id
  end
end
