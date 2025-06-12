class AddSocialLinkToAdminUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :social_link, :string
  end
end
