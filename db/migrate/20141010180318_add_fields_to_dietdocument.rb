class AddFieldsToDietdocument < ActiveRecord::Migration
  def change
    add_column :dietdocuments, :name,        :string
    add_column :dietdocuments, :description, :string
  end
end
