class CreateRifas < ActiveRecord::Migration[8.0]
  def change
    create_table :rifas do |t|
      t.string :nome
      t.text :descricao
      t.decimal :preco_ticket
      t.datetime :data_sorteio
      t.integer :total_tickets
      t.integer :tickets_vendidos
      t.string :status

      t.timestamps
    end
  end
end
