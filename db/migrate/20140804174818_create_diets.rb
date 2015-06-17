class CreateDiets < ActiveRecord::Migration
  def change
    create_table :diets do |t|
      t.references :student, index: true
      t.references :schoolyear, index: true

      t.timestamps
    end
  end
end
