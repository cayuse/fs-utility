class CreateSitesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :sites_users, :id=> false do |t|
      t.column :site_id, :integer
      t.column :user_id, :integer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sites_users
  end
end