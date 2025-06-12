# app/controllers/concerns/admin_authentication.rb

module AdminAuthentication
  extend ActiveSupport::Concern

  included do
    # Este filtro garante que qualquer acesso a um controlador que inclua este concern
    # só será permitido se houver um AdminUser logado.
    before_action :authenticate_admin_user!

    # Torna os helpers do Devise disponíveis para as views e outros métodos do controlador
    # que incluem este concern.
    helper_method :admin_user_signed_in?, :current_admin_user, :admin_user_session
  end
end
