# app/helpers/application_helper.rb
module ApplicationHelper
  # Helper para exibir a imagem de perfil ou um placeholder
  # record: O objeto do model (AdminUser, Partner)
  # default_image_name: O nome do arquivo da imagem padrão (ex: 'default_profile.png')
  # options: Hash de opções para o image_tag
  def display_model_image(record, default_image_name, options = {})
    if record.photo.attached?
      # Usa a foto anexada via Active Storage
      image_tag record.photo, options
    else
      # SOLUÇÃO DE CONTORNO DEFINITIVA: Carrega imagem diretamente da pasta /public/images
      # Isso ignora o asset pipeline e é útil quando ele está falhando persistentemente em desenvolvimento.
      # Assegure-se de que o arquivo default_image_name (ex: 'default_profile.png') está em public/images/
      image_tag "/images/#{default_image_name}", options # <-- Caminho ajustado para /public/images/
    end
  end
end
