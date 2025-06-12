# app/controllers/application_controller.rb
# ESTE É O CONTROLADOR BASE GLOBAL PARA TODO O SEU SITE (PÚBLICO E ADMIN)

class ApplicationController < ActionController::Base
  # Qualquer filtro ou método que você queira aplicar a TODOS
  # os controladores do seu site (público e admin) pode vir aqui.

  protected

  # Sobrescreve o método after_sign_in_path_for do Devise
  # para direcionar o AdminUser para o painel de administração.
  def after_sign_in_path_for(resource)
    # Verifica se o recurso que acabou de fazer login é uma instância de AdminUser
    if resource.is_a?(AdminUser)
      # Se for um AdminUser, redireciona para o dashboard de admin.
      # 'admin_root_path' é o helper de rota correto para a rota 'root'
      # dentro do seu namespace :admin.
      admin_root_path # <-- Esta é a mudança que resolve o problema!
    else
      # Para outros tipos de usuários (se você tiver outros modelos) ou
      # para o comportamento padrão do Devise, se o recurso não for AdminUser.
      # Geralmente redireciona para root_path ou para a página de onde o login foi iniciado.
      super
    end
  end
end
