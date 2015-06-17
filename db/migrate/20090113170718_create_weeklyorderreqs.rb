class CreateWeeklyorderreqs < ActiveRecord::Migration
  def self.up
    create_table :weeklyorderreqs do |t|
      t.references :sitetype
      t.date :week
      t.date :due
      t.boolean :mon
      t.boolean :tue
      t.boolean :wed
      t.boolean :thu
      t.boolean :fri
      t.boolean :finalized

      t.timestamps
    end
  end

  def self.down
    drop_table :weeklyorderreqs
  end
end
