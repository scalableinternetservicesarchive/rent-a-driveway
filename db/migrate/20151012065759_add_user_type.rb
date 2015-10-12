class AddUserType < ActiveRecord::Migration
  def change
  	add_column :users, :is_admin, :boolean, default: false
  	add_column :users, :is_buyer, :boolean, default: false
  	add_column :users, :is_seller, :boolean, default: false
  end
end
