# app/models/poll_option.rb

class PollOption < ApplicationRecord
  belongs_to :poll # Uma opção pertence a uma enquete
  has_many :poll_votes, dependent: :destroy # Uma opção tem muitos votos, e se a opção for apagada, os votos dela também

  validates :option_text, presence: true
  validates :option_text, uniqueness: { scope: :poll_id, message: "já existe para esta enquete" } # Opções únicas por enquete
end
