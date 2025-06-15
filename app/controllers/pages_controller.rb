# app/controllers/pages_controller.rb

class PagesController < ApplicationController
  def index
  end

  def bts
    @active_vote_links = VoteLink.where(is_active: true).order(created_at: :desc)
  end

  def jsn
  end

  # Ação para a página "Equipe JSN" (rota: /equipe)
  def equipe
    # Busca a Vitória (Admin Principal)
    # Recomendado: use o campo 'is_principal: true' como identificador principal.
    # Isso é mais robusto do que um email hardcoded, caso o email mude.
    @vitoria = AdminUser.find_by(is_principal: true)

    # Busca todos os administradores que NÃO são principais,
    # e que estão marcados para aparecer na página da equipe ('show_on_team_page: true').
    # Exclui a Vitória para não duplicar a exibição.
    @colaboradores = AdminUser.where(is_principal: false, show_on_team_page: true)
                              .where.not(id: @vitoria&.id) # Garante que a Vitória não apareça duas vezes
                              .order(name: :asc) # Ordena por nome para exibição

    # Busca todos os parceiros para exibir na página da equipe
    @partners = Partner.all.order(name: :asc) # Ordena por nome
  end

  def sorteios
    @active_sorteios = Sorteio.where(ativo: true).order(data_sorteio: :asc) # Pega apenas os sorteios ativos
  end

  def faca_parte
  end

  def novidades
    @news_posts = NewsPost.all.order(created_at: :desc) # Adicionado NewsPost.all e ordenação
  end
end
