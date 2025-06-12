# app/controllers/admin/vote_links_controller.rb
module Admin
  class VoteLinksController < Admin::ApplicationController
    before_action :set_vote_link, only: %i[ show edit update destroy toggle_active ]

    def index
      @vote_links = VoteLink.all.order(created_at: :desc)
    end

    def show; end
    def new; @vote_link = VoteLink.new; end
    def edit; end

    def create
      @vote_link = VoteLink.new(vote_link_params)
      if @vote_link.save
        redirect_to admin_vote_links_path, notice: "Link de votação criado com sucesso!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @vote_link.update(vote_link_params)
        redirect_to admin_vote_links_path, notice: "Link de votação atualizado com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @vote_link.destroy
      redirect_to admin_vote_links_path, notice: "Link de votação excluído."
    end

    def toggle_active
      @vote_link.update(is_active: !@vote_link.is_active)
      redirect_to admin_vote_links_path, notice: "Status do link de votação alterado!"
    end

    private

    def set_vote_link
      @vote_link = VoteLink.find(params[:id])
    end

    def vote_link_params
      params.require(:vote_link).permit(:title, :url, :description, :is_active) # CORRIGIDO: :title
    end
  end
end
