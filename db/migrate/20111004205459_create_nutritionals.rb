class CreateNutritionals < ActiveRecord::Migration
  def self.up
    create_table :nutritionals do |t|
      t.string :category
      t.string :name
      t.string :codenum
      t.text :search
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :nutritionals
  end
end
