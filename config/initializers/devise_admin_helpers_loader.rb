# config/initializers/devise_admin_helpers_loader.rb

# Este inicializador garante que os helpers do Devise sejam incluídos nos
# controladores e nas views dentro do namespace 'Admin'.
# Ele usa ActiveSupport.on_load para garantir que o Devise já esteja carregado.

ActiveSupport.on_load(:action_controller) do
  # Quando um ActionController é carregado, verifica se está dentro do módulo Admin
  # e se ainda não incluiu os helpers do Devise.
  if defined?(Admin) && self.ancestors.include?(Admin) && !self.included_modules.include?(Devise::Controllers::Helpers)
    include Devise::Controllers::Helpers
  end
end

ActiveSupport.on_load(:action_view) do
  # Quando um ActionView é carregado, verifica se está dentro do módulo Admin
  # e se ainda não incluiu os helpers do Devise.
  if defined?(Admin) && self.ancestors.include?(Admin) && !self.included_modules.include?(Devise::Controllers::Helpers)
    include Devise::Controllers::Helpers
  end
end
