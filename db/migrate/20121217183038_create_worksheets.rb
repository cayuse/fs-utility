class CreateWorksheets < ActiveRecord::Migration
  def self.up
    create_table :worksheets do |t|
      t.string :name
      t.string :description
      t.string :sheet_file_name
      t.string :sheet_content_type
      t.integer :sheet_file_size
      t.datetime :sheet_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :worksheets
  end
end
