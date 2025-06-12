# app/controllers/admin/application_controller.rb

module Admin
  class ApplicationController < ::ApplicationController
    # Este filtro do Devise garante que só administradores logados possam acessar.
    before_action :authenticate_admin_user!

    # Define o layout 'admin' para todos os controladores dentro deste namespace.
    layout "admin"

    # REMOVIDOS AQUI: after_sign_in_path_for e after_sign_out_path_for
    # Eles foram movidos para app/controllers/admin_users/sessions_controller.rb
  end
end
