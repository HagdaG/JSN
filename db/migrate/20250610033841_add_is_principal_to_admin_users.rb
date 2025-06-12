# db/migrate/YYYYMMDDHHMMSS_add_is_principal_to_admin_users.rb
class AddIsPrincipalToAdminUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :is_principal, :boolean, default: false, null: false # <--- ALTERADO AQUI!
  end
end
