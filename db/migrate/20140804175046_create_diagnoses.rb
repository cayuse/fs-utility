class CreateDiagnoses < ActiveRecord::Migration
  def change
    create_table :diagnoses do |t|
      t.references :diet, index: true
      t.references :condition, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
