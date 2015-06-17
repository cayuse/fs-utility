class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.references :user
      t.references :site
      t.references :track
      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
