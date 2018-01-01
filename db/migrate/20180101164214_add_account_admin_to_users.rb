class AddAccountAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_admin, :boolean, default: false
  end
end
