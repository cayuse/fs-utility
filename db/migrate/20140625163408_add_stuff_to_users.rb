class AddStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :fullname, :string
  end
end
