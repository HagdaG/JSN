# app/models/partner.rb

class Partner < ApplicationRecord
  # Associa uma imagem ao parceiro usando Active Storage
  has_one_attached :photo

  # Adicione validações se desejar (ex: presença de nome, link, foto)
  validates :name, presence: true, uniqueness: true
  # validates :photo, attached: true, content_type: ['image/png', 'image/jpeg'] # Exemplo de validação de imagem
end
