class AddAttachmentDietscanToDietdocuments < ActiveRecord::Migration
  def self.up
    change_table :dietdocuments do |t|
      t.attachment :dietscan
    end
  end

  def self.down
    remove_attachment :dietdocuments, :dietscan
  end
end
