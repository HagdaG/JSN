class CreateNewsPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :news_posts do |t|
      t.string :titulo
      t.text :conteudo
      t.datetime :data_publicacao

      t.timestamps
    end
  end
end
