class CreateSchoolyears < ActiveRecord::Migration
  def change
    create_table :schoolyears do |t|
      t.string :name

      t.timestamps
    end
  end
end
