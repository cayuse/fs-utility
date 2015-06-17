class CreateDietdocuments < ActiveRecord::Migration
  def change
    create_table :dietdocuments do |t|
      t.references :student, index: true

      t.timestamps
    end
  end
end
