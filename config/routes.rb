Rails.application.routes.draw do
  # Página inicial (home)
  root "pages#home"

  # Páginas adicionais
  get "sorteios", to: "pages#sorteios"
  get "ganhadores", to: "pages#ganhadores"
  get "equipe", to: "pages#equipe"
  get "apoie", to: "pages#apoie"
  get "streams", to: "pages#streams"
end
