class AddBioToAdminUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :bio, :text
  end
end
