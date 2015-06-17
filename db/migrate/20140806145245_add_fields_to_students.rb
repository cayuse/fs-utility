class AddFieldsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :active, :bool
    add_column :students, :phone, :string
    add_column :students, :email, :string
    add_column :students, :request_status, :integer, default: 0
    add_column :students, :birthdate, :date
    add_reference :students, :approved_by, index: true
  end
end
