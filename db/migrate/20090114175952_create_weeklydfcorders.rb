class CreateWeeklydfcorders < ActiveRecord::Migration
  def self.up
    create_table :weeklydfcorders do |t|
      t.references :weeklyorderreq
      t.references :site
      
      t.timestamps
    end
  end

  def self.down
    drop_table :weeklydfcorders
  end
end
