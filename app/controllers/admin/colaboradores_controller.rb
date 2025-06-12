# app/controllers/admin/colaboradores_controller.rb
module Admin
  class ColaboradoresController < Admin::ApplicationController # <--- NOME DA CLASSE MUDOU
    # Apenas o administrador principal pode acessar estas ações (MANTIDA A RESTRIÇÃO)
    before_action :authenticate_principal_admin!
    before_action :set_colaborador, only: %i[show edit update destroy] # <--- set_admin_user MUDOU PARA set_colaborador

    # Lista todos os administradores (agora chamados de colaboradores)
    def index
      @colaboradores = AdminUser.all.order(name: :asc, email: :asc) # <--- @admin_users MUDOU PARA @colaboradores
    end

    # Exibe os detalhes de um colaborador (opcional)
    def show; end

    # Carrega um colaborador para edição
    def edit; end

    # Atualiza os dados de um colaborador
    def update
      # Se os campos de senha estiverem vazios, Devise não atualizará a senha.
      if colaborador_params[:password].blank? && colaborador_params[:password_confirmation].blank?
        params_to_update = colaborador_params.except(:password, :password_confirmation)
      else
        params_to_update = colaborador_params
      end

      if @colaborador.update(params_to_update) # <--- @admin_user MUDOU PARA @colaborador
        redirect_to admin_colaboradores_path, notice: "Colaborador atualizado com sucesso!" # <--- admin_admin_users_path MUDOU
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # Exclui um colaborador
    def destroy
      # Não permitir que um admin exclua a si mesmo
      if @colaborador == current_admin_user # <--- @admin_user MUDOU PARA @colaborador
        redirect_to admin_colaboradores_path, alert: "Você não pode excluir sua própria conta!" # <--- admin_admin_users_path MUDOU
      else
        @colaborador.destroy # <--- @admin_user MUDOU PARA @colaborador
        redirect_to admin_colaboradores_path, notice: "Colaborador excluído com sucesso!" # <--- admin_admin_users_path MUDOU
      end
    end

    private

    # Encontra o AdminUser pelo ID
    def set_colaborador # <--- set_admin_user MUDOU PARA set_colaborador
      @colaborador = AdminUser.find(params[:id]) # <--- @admin_user MUDOU PARA @colaborador
    end

    # Strong parameters para AdminUser (agora chamado colaborador_params)
    def colaborador_params # <--- admin_user_params MUDOU PARA colaborador_params
      params.require(:admin_user).permit(:name, :email, :password, :password_confirmation, :photo, :is_principal)
    end
  end
end
