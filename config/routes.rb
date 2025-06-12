# JSN_web/config/routes.rb

Rails.application.routes.draw do
  # Sua rota para a página inicial
  root "pages#index"

  # Suas outras rotas existentes para navegação
  get "bts", to: "pages#bts", as: "bts_info"
  get "jsn", to: "pages#jsn", as: "jsn_project"
  get "equipe", to: "pages#equipe", as: "jsn_team"
  get "sorteios", to: "pages#sorteios", as: "jsn_raffles_and_partnerships"
  get "faca-parte", to: "pages#faca_parte", as: "support"
  get "novidades", to: "pages#novidades", as: "jsn_novelties" # Rota pública para Novidades

  # Rotas para as mensagens públicas (envio e visualização da galeria)
  resources :messages, only: [ :create ] # Para o formulário de envio da home
  get "todos-somos-jsn", to: "messages#index", as: "todos_somos_jsn" # Para a galeria pública

  # Rotas para registrar cópias de chave PIX (se você implementou o rastreamento)
  resources :pix_copy_logs, only: [ :create ]

  # Rotas do Devise para AdminUser
  devise_for :admin_users, controllers: {
    sessions: "admin_users/sessions",
    passwords: "admin_users/passwords",
    registrations: "admin_users/registrations"
    # Confirme se você usa os módulos abaixo no AdminUser.rb para descomentar
    # confirmations: 'admin_users/confirmations',
    # unlocks: 'admin_users/unlocks',
    # omniauth_callbacks: 'admin_users/omniauth_callbacks'
  }

  # --- ROTAS DO PAINEL ADMINISTRATIVO ---
  namespace :admin do
    # Rota para o dashboard do painel administrativo
    get "/", to: "dashboard#index", as: "dashboard"

    # Rotas para gerenciar AdminUsers (administradores - CRIAR, EDITAR, EXCLUIR ADMINS)
    resources :admin_users # <--- RESTAURADO AQUI!

    # Rota para o admin editar o próprio perfil (mantida, pois é para o próprio login)
    resource :profile, only: [ :edit, :update ], controller: "admin_users/registrations"

    # Rotas para gerenciar mensagens no painel administrativo
    resources :messages, only: [ :index, :update, :destroy ] do
      member do
        patch :approve
        patch :reject
      end
    end

    # Rotas para gerenciar links de votação no painel administrativo
    resources :vote_links do
      member do
        patch :toggle_active
        get :increment_clicks # Para rastrear cliques em links de votação
      end
    end

    # Rotas para gerenciar parceiros no painel administrativo
    resources :partners # <--- MANTIDO AQUI para gerenciar parceiros, NÃO ADMINUSERS

    # Rotas para gerenciar enquetes no painel administrativo
    resources :polls do
      member do
        patch :toggle_active # Ativar/desativar enquete
      end
      resources :poll_options, only: [ :new, :create, :edit, :update, :destroy ] # Opções de enquete aninhadas
    end

    # Rotas para gerenciar sorteios no painel administrativo
    resources :sorteios do
      member do
        patch :toggle_ativo
      end
    end

    # Rotas para gerenciar novidades no painel administrativo
    resources :news_posts
  end
  # --- FIM ROTAS DO PAINEL ADMINISTRATIVO ---
end
