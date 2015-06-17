class CreateStudentMeals < ActiveRecord::Migration
  def change
    create_table :student_meals do |t|
      t.references :student, index: true
      t.references :meal, index: true

      t.timestamps
    end
  end
end
