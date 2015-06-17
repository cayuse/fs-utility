class AddUserToDiet < ActiveRecord::Migration
  def change
    add_reference :diets, :user, index: true
  end
end
