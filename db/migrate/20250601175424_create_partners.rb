class CreatePartners < ActiveRecord::Migration[8.0]
  def change
    create_table :partners do |t|
      t.string :name
      t.text :bio
      t.string :social_link

      t.timestamps
    end
  end
end
