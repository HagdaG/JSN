# app/controllers/admin/sorteios_controller.rb
module Admin
  class SorteiosController < Admin::ApplicationController
    before_action :set_sorteio, only: %i[ show edit update destroy toggle_ativo ]

    def index
      @sorteios = Sorteio.all.order(created_at: :desc)
    end

    def show; end
    def new; @sorteio = Sorteio.new; end
    def edit; end

    def create
      @sorteio = Sorteio.new(sorteio_params)
      if @sorteio.save
        redirect_to admin_sorteios_path, notice: "Sorteio foi criado com sucesso."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @sorteio.update(sorteio_params)
        redirect_to admin_sorteios_path, notice: "Sorteio foi atualizado com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @sorteio.destroy
      redirect_to admin_sorteios_path, notice: "Sorteio foi excluído com sucesso."
    end

    def toggle_ativo
      @sorteio.toggle!(:ativo)
      redirect_to admin_sorteios_path, notice: "Status do sorteio atualizado."
    end

    private
      def set_sorteio
        @sorteio = Sorteio.find(params[:id])
      end

      def sorteio_params
        params.require(:sorteio).permit(:titulo, :descricao, :link_sorteio, :data_sorteio, :ativo, :photo) # <--- ADICIONADO :photo AQUI
      end
  end
end
