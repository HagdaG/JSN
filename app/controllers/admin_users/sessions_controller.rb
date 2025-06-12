# app/controllers/admin_users/sessions_controller.rb

class AdminUsers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # --- LÓGICA DE REDIRECIONAMENTO PÓS-LOGIN (AGORA PARA O DASHBOARD!) ---
  def after_sign_in_path_for(resource)
    # Redireciona para o dashboard administrativo após o login bem-sucedido.
    admin_dashboard_path # <-- CORRIGIDO AQUI!
  end

  # Redireciona para a página inicial APÓS o logout
  def after_sign_out_path_for(resource)
    root_path
  end
  # --- FIM LÓGICA DE REDIRECIONAMENTO ---
end
