class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :status
      t.string :user_name

      t.timestamps
    end
  end
end
