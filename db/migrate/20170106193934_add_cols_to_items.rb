class AddColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :mfgname,    :string
    add_column :items, :mfgcode,    :string
    add_column :items, :ordercode,  :string
  end
end
