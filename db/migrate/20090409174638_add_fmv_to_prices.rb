class AddFmvToPrices < ActiveRecord::Migration
  def self.up
    add_column :prices, :fmv_in_cents, :integer
  end

  def self.down
    remove_column :prices, :fmv_in_cents
  end
end
