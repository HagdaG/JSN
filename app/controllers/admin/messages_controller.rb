# app/controllers/admin/messages_controller.rb

module Admin
  class MessagesController < Admin::ApplicationController
    before_action :set_message, only: %i[approve reject destroy]
    before_action :set_message_counts, only: %i[index pending approved rejected]

    # Ação padrão para /admin/messages: Exibe mensagens pendentes por padrão.
    def index
      @messages = Message.where(status: :pending).order(created_at: :desc)
      @current_filter = :pending
    end

    # Ação para listar Mensagens Pendentes (/admin/messages/pending)
    def pending
      @messages = Message.where(status: :pending).order(created_at: :desc)
      @current_filter = :pending
      render :index
    end

    # Ação para listar Mensagens Aprovadas (/admin/messages/approved)
    def approved
      @messages = Message.where(status: :approved).order(updated_at: :desc)
      @current_filter = :approved
      render :index
    end

    # Ação para listar Mensagens Rejeitadas (/admin/messages/rejected)
    def rejected
      @messages = Message.where(status: :rejected).order(updated_at: :desc)
      @current_filter = :rejected
      render :index
    end

    # Ação para Aprovar uma mensagem
    def approve
      @message.update(status: :approved, approved: true)
      # CORREÇÃO: Redirecionamento para caminho literal
      redirect_to "/admin/messages/pending", notice: "Mensagem aprovada com sucesso! Você pode encontrá-la em Mensagens Aprovadas."
    end

    # Ação para Rejeitar uma mensagem
    def reject
      @message.update(status: :rejected, approved: false)
      # CORREÇÃO: Redirecionamento para caminho literal
      redirect_to "/admin/messages/pending", notice: "Mensagem rejeitada. Você pode encontrá-la em Mensagens Rejeitadas."
    end

    def destroy
      @message.destroy
      # CORREÇÃO: Redirecionamento para caminho literal
      redirect_to "/admin/messages/pending", notice: "Mensagem excluída."
    end

    private

    def set_message
      @message = Message.find(params[:id])
    end

    def set_message_counts
      @pending_count = Message.where(status: :pending).count
      @approved_count = Message.where(status: :approved).count
      @rejected_count = Message.where(status: :rejected).count
      @all_count = Message.count
    end
  end
end
