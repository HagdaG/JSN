# app/models/admin_user.rb
class AdminUser < ApplicationRecord
  # Inclui módulos Devise. Outros módulos disponíveis são:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

  # Adiciona o anexo de foto usando Active Storage
  has_one_attached :photo

  # Validação para o nome (será obrigatório ao atualizar o perfil)
  # A validação 'presence: true' só ocorrerá se o nome estiver nos parâmetros da atualização.
  validates :name, presence: true, on: :update, if: :name_present_in_params?

  # Validação opcional para a foto
  validates :photo, content_type: [ "image/png", "image/jpeg", "image/gif" ], # Tipos de imagem permitidos
                     size: { less_than: 5.megabytes, message: "deve ser menor que 5MB" }, # Tamanho máximo
                     if: -> { photo.attached? } # Aplica validação apenas se uma foto for anexada

  # Validação opcional para a biografia
  validates :bio, length: { maximum: 500 }, allow_blank: true # <--- ADICIONADO AQUI!

  private

  # Helper para a validação condicional do nome
  # Garante que a validação de presença do nome só ocorra se o nome estiver nos parâmetros sendo atualizados
  def name_present_in_params?
    persisted? && changes.key?("name") # Verifica se o objeto já existe e se o 'name' está sendo alterado
  end
end
