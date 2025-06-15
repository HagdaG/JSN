class AddShowOnTeamPageToAdminUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :show_on_team_page, :boolean
  end
end
