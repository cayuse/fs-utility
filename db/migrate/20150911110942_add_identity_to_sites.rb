class AddIdentityToSites < ActiveRecord::Migration
  def change
    add_column :sites, :identity,        :string
  end
end
