class CreateItemtypeUsagesJoins < ActiveRecord::Migration
  def self.up
    create_table :itemtypes_usages, :id=> false do |t|
      t.column :itemtype_id, :integer
      t.column :usage_id, :integer

      t.timestamps
    end
  end

  def self.down
    drop_table :itemtypes_usages
  end
end
