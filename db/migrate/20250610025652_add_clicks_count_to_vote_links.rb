# db/migrate/YYYYMMDDHHMMSS_add_clicks_count_to_vote_links.rb
class AddClicksCountToVoteLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :vote_links, :clicks_count, :integer, default: 0
  end
end
