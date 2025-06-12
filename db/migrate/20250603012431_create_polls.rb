# app/models/poll.rb

class Poll < ApplicationRecord
  has_many :poll_options, dependent: :destroy # Uma enquete tem muitas opções, e se a enquete for apagada, as opções também
  has_many :poll_votes, through: :poll_options # Uma enquete tem muitos votos através de suas opções

  validates :question, presence: true, uniqueness: true

  # Método para saber se a enquete tem votos
  def has_votes?
    poll_votes.exists?
  end

  # Método para calcular a porcentagem de cada opção
  def total_votes
    poll_votes.count
  end

  def percentage_for(option)
    return 0 if total_votes.zero?
    (option.poll_votes.count.to_f / total_votes * 100).round(1)
  end
end
