# app/controllers/admin/admin_users_controller.rb
module Admin
  class AdminUsersController < Admin::ApplicationController
    # Apenas o administrador principal pode acessar estas ações
    before_action :authenticate_principal_admin!, only: [ :index, :show, :edit, :update, :destroy ]
    before_action :set_admin_user, only: %i[show edit update destroy]

    # Lista todos os administradores
    def index
      @admin_users = AdminUser.all.order(name: :asc, email: :asc)
    end

    # Exibe os detalhes de um administrador (opcional)
    def show; end

    # Carrega um administrador para edição
    def edit; end

    # Atualiza os dados de um administrador
    def update
      if admin_user_params[:password].blank? && admin_user_params[:password_confirmation].blank?
        params_to_update = admin_user_params.except(:password, :password_confirmation)
      else
        params_to_update = admin_user_params
      end

      if @admin_user.update(params_to_update)
        redirect_to admin_admin_users_path, notice: "Administrador atualizado com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # Exclui um administrador
    def destroy
      if @admin_user == current_admin_user
        redirect_to admin_admin_users_path, alert: "Você não pode excluir sua própria conta!"
      else
        @admin_user.destroy
        redirect_to admin_admin_users_path, notice: "Administrador excluído com sucesso!"
      end
    end

    private

    # Encontra o AdminUser pelo ID
    def set_admin_user
      @admin_user = AdminUser.find(params[:id])
    end

    # Método para verificar se o usuário logado é o administrador principal
    # (Este método deve estar em Admin::ApplicationController, se ainda não estiver lá)
    def authenticate_principal_admin!
      unless current_admin_user&.is_principal?
        redirect_to admin_dashboard_path, alert: "Você não tem permissão para acessar esta área."
      end
    end

    # Strong parameters para AdminUser (CORRIGIDO AQUI!)
    def admin_user_params
      params.require(:admin_user).permit(:name, :email, :password, :password_confirmation, :photo, :is_principal, :bio) # <--- ADICIONADO :bio AQUI!
    end
  end
end
