class CreateVoteLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :vote_links do |t|
      t.string :title
      t.string :url
      t.text :description
      t.boolean :is_active

      t.timestamps
    end
  end
end
