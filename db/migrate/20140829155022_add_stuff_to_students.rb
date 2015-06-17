class AddStuffToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :student_meals, index: true
    add_column :students, :priority, :bool
    remove_column :students, :approved_by_id
  end
end
