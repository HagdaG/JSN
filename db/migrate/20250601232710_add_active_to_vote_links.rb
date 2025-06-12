class AddActiveToVoteLinks < ActiveRecord::Migration[8.0]
  def change
    add_column :vote_links, :active, :boolean
  end
end
