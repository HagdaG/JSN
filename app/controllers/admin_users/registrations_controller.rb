# app/controllers/admin_users/registrations_controller.rb
# frozen_string_literal: true

class AdminUsers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource/sign_up
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if you want to protect
  # against CSRF attacks.
  # def cancel
  #   super
  # end

  protected

  # Se você tiver parâmetros extras para permitir na criação de conta, adicione-os aqui.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
  end

  # Se você tiver parâmetros extras para permitir na atualização de conta, adicione-os aqui.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :photo])
  end

  # O caminho usado após o registro.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # O caminho usado após a edição de uma conta.
  # def after_update_path_for(resource)
  #   super(resource)
  # end
end