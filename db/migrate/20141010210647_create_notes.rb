class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :student, index: true
      t.text :entry
      
      t.timestamps
    end
  end
end
