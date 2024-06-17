class AddUserRefTopatients < ActiveRecord::Migration[6.0]
#   def change
#     add_reference :patients, :user, null: false, foreign_key: true
#   end

  def self.up
    add_reference :patients, :user, foreign_key: true
    change_column :patients, :user_id, :integer, null: false, foreign_key: true
  end

  def self.down
    remove_column :patients, :user_id
  end
end
