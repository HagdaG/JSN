# app/controllers/messages_controller.rb
# ESTE É O CONTROLADOR PARA AS MENSAGENS NO SITE PÚBLICO
# Ele lida com a exibição das mensagens aprovadas e o envio de novas mensagens.
class MessagesController < ApplicationController # Herda de ApplicationController (NÃO Admin::ApplicationController)
  # Ação para exibir a lista de mensagens aprovadas publicamente na página "Todos Somos JSN"
  def index
    # BUSCA ATUALIZADA: Agora busca mensagens com status 'approved'
    @approved_messages = Message.where(status: "approved").order(created_at: :desc)
  end

  # Ação para receber o envio de novas mensagens do formulário na página inicial
  def create
    # ATUALIZADO: Definir o status como 'pending' ao criar uma nova mensagem
    # Isso garante que a mensagem aparecerá no painel de administração para aprovação.
    @message = Message.new(message_params.merge(status: "pending"))

    if @message.save
      # Redireciona para a página inicial com uma mensagem de sucesso
      redirect_to root_path, notice: "Sua história foi enviada com sucesso e será revisada pela nossa equipe!"
    else
      # Redireciona para a página inicial com uma mensagem de erro se houver problemas
      redirect_to root_path, alert: "Não foi possível enviar sua história. Por favor, tente novamente."
    end
  end

  private

  # Método para permitir apenas os parâmetros seguros para a criação de uma mensagem
  # O status não deve ser permitido ser definido pelo usuário comum.
  def message_params
    params.require(:message).permit(:content, :user_name)
  end
end
