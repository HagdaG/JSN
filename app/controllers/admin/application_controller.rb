# app/controllers/admin/application_controller.rb

module Admin
  class ApplicationController < ::ApplicationController
    # Este filtro do Devise garante que só administradores logados possam acessar todo o namespace /admin.
    before_action :authenticate_admin_user!

    # Define o layout 'admin' para todos os controladores dentro deste namespace.
    layout "admin"

    # Método para verificar se o usuário logado é o administrador principal (a Vitória).
    # Este método é 'protected' para que possa ser usado como 'before_action' em controladores filhos.
    protected
    def authenticate_principal_admin!
      unless current_admin_user&.is_principal?
        redirect_to admin_dashboard_path, alert: "Você não tem permissão para acessar esta área restrita."
      end
    end
    # REMOVIDOS AQUI: after_sign_in_path_for e after_sign_out_path_for
    # Eles foram movidos para app/controllers/admin_users/sessions_controller.rb (que é o local correto do Devise)
  end
end
