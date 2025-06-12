# app/controllers/admin/partners_controller.rb
module Admin
  class PartnersController < Admin::ApplicationController
    # Isso garante que apenas o admin principal tenha acesso a estas ações
    # (se authenticate_principal_admin! estiver em Admin::ApplicationController, não defina aqui)
    before_action :authenticate_admin_user!, only: [ :index, :new, :create, :edit, :update, :destroy ]
    before_action :set_partner, only: %i[ edit update destroy ]

    def index
      @partners = Partner.all.order(name: :asc)
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
      # @partner é definido por set_partner
      if @partner.update(partner_params)
        redirect_to admin_partners_path, notice: "Parceiro atualizado com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      # @partner é definido por set_partner
      @partner.destroy
      redirect_to admin_partners_path, notice: "Parceiro excluído."
    end

    private

    def set_partner
      @partner = Partner.find(params[:id])
    end

    # authenticate_principal_admin! deve estar em Admin::ApplicationController
    # remova-o se já estiver no arquivo pai
    # def authenticate_principal_admin!
    #   unless current_admin_user&.is_principal?
    #     redirect_to admin_dashboard_path, alert: "Você não tem permissão para acessar esta área."
    #   end
    # end

    def partner_params
      params.require(:partner).permit(:name, :bio, :social_link, :photo)
    end
  end
end
