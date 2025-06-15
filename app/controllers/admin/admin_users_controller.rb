# app/controllers/admin/admin_users_controller.rb

module Admin
  class AdminUsersController < Admin::ApplicationController
    # Apenas o administrador principal pode acessar estas ações de gerenciamento de usuários.
    before_action :authenticate_principal_admin!
    before_action :set_admin_user, only: %i[show edit update destroy]

    # Lista todos os administradores, ordenados por nome ou e-mail.
    def index
      @admin_users = AdminUser.all.order(name: :asc, email: :asc)
    end

    # Exibe os detalhes de um administrador (opcional).
    def show; end

    # Ação para exibir o formulário de criação de um novo administrador.
    def new
      @admin_user = AdminUser.new
    end

    # Ação para processar a criação de um novo administrador.
    def create
      @admin_user = AdminUser.new(admin_user_params)
      if @admin_user.save
        redirect_to admin_admin_users_path, notice: "Administrador criado com sucesso!"
      else
        # Se houver erros de validação, renderiza o formulário novamente com os erros.
        render :new, status: :unprocessable_entity
      end
    end

    # Carrega um administrador para edição.
    def edit; end # A view 'edit.html.erb' será renderizada automaticamente.

    # Atualiza os dados de um administrador.
    def update
      # Se os campos de senha estiverem vazios, Devise não atualizará a senha.
      # Isso evita exigir senha para cada edição de perfil.
      if admin_user_params[:password].blank? && admin_user_params[:password_confirmation].blank?
        params_to_update = admin_user_params.except(:password, :password_confirmation)
      else
        params_to_update = admin_user_params
      end

      # Não permitir que um AdminUser normal marque a si mesmo como 'is_principal'.
      # Apenas a Vitória deveria ter controle sobre quem é principal.
      # Se o usuário logado NÃO é principal, remove a permissão para mudar 'is_principal' e 'show_on_team_page'.
      if !current_admin_user.is_principal?
        params_to_update = params_to_update.except(:is_principal, :show_on_team_page)
      end

      if @admin_user.update(params_to_update)
        redirect_to admin_admin_users_path, notice: "Administrador atualizado com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # Exclui um administrador.
    def destroy
      # Não permitir que um administrador exclua a si mesmo.
      if @admin_user == current_admin_user
        redirect_to admin_admin_users_path, alert: "Você não pode excluir sua própria conta!"
      # Não permitir que o administrador principal (Vitória) seja excluída.
      elsif @admin_user.is_principal?
        redirect_to admin_admin_users_path, alert: "O administrador principal não pode ser excluído!"
      else
        @admin_user.destroy
        redirect_to admin_admin_users_path, notice: "Administrador excluído com sucesso!"
      end
    end

    private

    # Encontra o AdminUser pelo ID.
    def set_admin_user
      @admin_user = AdminUser.find(params[:id])
    end

    # Strong parameters para AdminUser.
    # Certifique-se de que todos esses campos estão no seu db/schema.rb para AdminUser.
    def admin_user_params
      params.require(:admin_user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :photo, # Permite o upload de foto de perfil via Active Storage
        :is_principal, # Para marcar a Vitória como principal
        :bio, # Biografia
        :social_link, # Link de rede social
        :show_on_team_page # Para decidir se aparece na página da equipe
      )
    end
  end
end
