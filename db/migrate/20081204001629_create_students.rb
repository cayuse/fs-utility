class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.integer :number
      t.string :name
      t.string :homeroom
      t.integer :grade
      t.string :track
      t.boolean :intersession
      t.integer :site_id

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
