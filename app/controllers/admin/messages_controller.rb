# app/controllers/admin/messages_controller.rb
# ESTE É O CONTROLADOR PARA GERENCIAR MENSAGENS NO PAINEL DE ADMINISTRAÇÃO

module Admin
  class MessagesController < Admin::ApplicationController # Herda de Admin::ApplicationController
    # Os métodos de autenticação e helpers do Devise vêm de Admin::ApplicationController

    layout "admin" # Define o layout específico para o painel de admin

    def index
      # --- ATENÇÃO: AS VARIÁVEIS DE MENSAGEM SÃO DEFINIDAS AQUI! ---
      @pending_messages = Message.where(status: "pending").order(created_at: :asc)
      @approved_messages = Message.where(status: "approved").order(created_at: :desc)
      @rejected_messages = Message.where(status: "rejected").order(created_at: :desc)
      # --- FIM DA DEFINIÇÃO DAS VARIÁVEIS ---
    end

    def approve
      @message = Message.find(params[:id])
      if @message.update(status: "approved")
        redirect_to admin_messages_path, notice: "Mensagem aprovada com sucesso!"
      else
        redirect_to admin_messages_path, alert: "Erro ao aprovar mensagem."
      end
    end

    def reject
      @message = Message.find(params[:id])
      if @message.update(status: "rejected")
        redirect_to admin_messages_path, notice: "Mensagem rejeitada com sucesso!"
      else
        redirect_to admin_messages_path, alert: "Erro ao rejeitar mensagem."
      end
    end

    def destroy
      @message = Message.find(params[:id])
      @message.destroy
      redirect_to admin_messages_path, notice: "Mensagem excluída com sucesso."
    end

    private

    def message_params
      params.require(:message).permit(:content, :user_name)
    end
  end
end
