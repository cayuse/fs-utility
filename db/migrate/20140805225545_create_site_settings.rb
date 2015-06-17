class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.belongs_to :schoolyear, index: true

      t.timestamps
    end
  end
end
