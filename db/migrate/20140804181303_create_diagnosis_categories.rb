class CreateDiagnosisCategories < ActiveRecord::Migration
  def change
    create_table :diagnosis_categories do |t|
      t.references :diagnosis, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
