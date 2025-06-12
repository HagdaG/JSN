# JSN_web/app/controllers/pages_controller.rb

class PagesController < ApplicationController
  def index
  end

  def bts
    @active_vote_links = VoteLink.where(is_active: true).order(created_at: :desc)
  end

  def jsn
  end

  def equipe
    # Busca a Vitória (Admin Principal)
    @vitoria = AdminUser.find_by(email: "admin@jsn.com") # <--- Use o e-mail real da Vitória aqui!

    # Busca todos os administradores que NÃO são principais (colaboradores)
    # e que têm um nome definido para serem exibidos publicamente
    @colaboradores = AdminUser.where(is_principal: false).where.not(name: [ nil, "" ]).order(name: :asc)

    # Busca todos os parceiros para exibir na página da equipe
    @partners = Partner.all.order(name: :asc) # Ordena por nome
  end

  def sorteios
    @active_sorteios = Sorteio.where(ativo: true).order(data_sorteio: :asc) # Pega apenas os sorteios ativos
  end

  def faca_parte
  end

  def novidades
    @news_posts = NewsPost.all # <--- ADICIONE ESTA LINHA AQUI!
  end
end
