# db/migrate/YYYYMMDDHHMMSS_add_name_to_admin_users.rb
class AddNameToAdminUsers < ActiveRecord::Migration[8.0] # A versão do Rails pode ser diferente
  def change
    add_column :admin_users, :name, :string, default: '', null: false # <--- ADICIONE default: '' e null: false
  end
end
