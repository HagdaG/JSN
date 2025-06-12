# app/models/news_post.rb
class NewsPost < ApplicationRecord
  # Para anexar uma imagem à novidade
  has_one_attached :photo

  # Validações opcionais para os campos
  validates :titulo, presence: true, length: { maximum: 255 }
  validates :conteudo, presence: true
  validates :data_publicacao, presence: true

  # Validações para a foto (opcional, mas boa prática)
  validates :photo, content_type: [ "image/png", "image/jpeg", "image/gif" ],
                    size: { less_than: 5.megabytes, message: "deve ser menor que 5MB" },
                    if: -> { photo.attached? }

  # Define a ordem padrão para as novidades (mais recentes primeiro)
  default_scope { order(data_publicacao: :desc) }
end
