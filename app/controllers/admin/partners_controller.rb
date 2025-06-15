# app/controllers/admin/partners_controller.rb

module Admin
  class PartnersController < Admin::ApplicationController
    # Garante que apenas o admin principal tenha acesso a estas ações.
    # authenticate_admin_user! já é herdado de Admin::ApplicationController
    before_action :authenticate_principal_admin!
    before_action :set_partner, only: %i[show edit update destroy]

    def index
      @partners = Partner.all.order(name: :asc)
    end

    def show
      # @partner é definido por set_partner
    end

    def new
      @partner = Partner.new
    end

    def create
      @partner = Partner.new(partner_params)
      if @partner.save
        redirect_to admin_partners_path, notice: "Parceiro criado com sucesso!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      # @partner é definido por set_partner
    end

    def update
      if @partner.update(partner_params)
        redirect_to admin_partners_path, notice: "Parceiro atualizado com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @partner.destroy
      redirect_to admin_partners_path, notice: "Parceiro excluído."
    end

    private

    def set_partner
      @partner = Partner.find(params[:id])
    end

    # Strong parameters para o Model Partner.
    # Certifique-se de que esses campos existem no seu db/schema.rb para Partner.
    def partner_params
      params.require(:partner).permit(:name, :description, :link, :photo) # :photo se você usa Active Storage
    end
  end
end
