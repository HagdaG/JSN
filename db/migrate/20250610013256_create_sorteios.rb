class CreateSorteios < ActiveRecord::Migration[8.0]
  def change
    create_table :sorteios do |t|
      t.string :titulo
      t.text :descricao
      t.string :link_sorteio
      t.datetime :data_sorteio
      t.boolean :ativo

      t.timestamps
    end
  end
end
