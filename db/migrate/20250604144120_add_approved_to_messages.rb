# db/migrate/YYYYMMDDHHMMSS_add_approved_to_messages.rb
class AddApprovedToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :approved, :boolean, default: false
  end
end
