class AddLinkToPartners < ActiveRecord::Migration[8.0]
  def change
    add_column :partners, :link, :string
  end
end
