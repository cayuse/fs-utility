class CreateFoodvendors < ActiveRecord::Migration
  def self.up
    create_table :foodvendors do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :contact
      t.string :phone
      t.string :fax
      t.string :email

      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :foodvendors
  end
end
