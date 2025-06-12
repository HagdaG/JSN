# app/models/sorteio.rb
class Sorteio < ApplicationRecord
  # Adiciona o anexo de foto usando Active Storage
  has_one_attached :photo # <--- ADICIONE ESTA LINHA

  # Validações opcionais para a foto do prêmio
  validates :photo, content_type: [ "image/png", "image/jpeg", "image/gif" ], # Tipos de imagem permitidos
                    size: { less_than: 5.megabytes, message: "deve ser menor que 5MB" }, # Tamanho máximo
                    if: -> { photo.attached? } # Aplica validação apenas se uma foto for anexada
end
