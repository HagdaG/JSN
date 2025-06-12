# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JsnWeb # OU o nome do seu módulo/aplicação (mantenha o que está aí)
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0 # Certifique-se de que seja 8.0 (ou a sua versão do Rails)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed after this file.
    #
    # E.g.
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # --- NOVA CONFIGURAÇÃO DE LOCALIZAÇÃO AQUI ---
    # Define o idioma padrão da sua aplicação para português do Brasil
    config.i18n.default_locale = :"pt-BR"
    # --- FIM NOVA CONFIGURAÇÃO ---

    # Adicione ou remova linhas daqui apenas se você souber o que está fazendo.
    # NENHUMA linha 'config.cssbundling' ou 'config.jsbundling' deve estar aqui.
  end
end
