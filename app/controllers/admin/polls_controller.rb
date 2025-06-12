# app/controllers/admin/polls_controller.rb

module Admin
  class PollsController < Admin::ApplicationController
    def index
      @polls = Poll.all.order(created_at: :desc)
    end

    def new
      @poll = Poll.new
    end

    def create
      @poll = Poll.new(poll_params)
      if @poll.save
        redirect_to admin_polls_path, notice: "Enquete criada com sucesso! Agora adicione as opções."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @poll = Poll.find(params[:id])
      @poll_option = @poll.poll_options.new # Para o formulário de nova opção
    end

    def edit
      @poll = Poll.find(params[:id])
    end

    def update
      @poll = Poll.find(params[:id])
      if @poll.update(poll_params)
        redirect_to admin_polls_path, notice: "Enquete atualizada com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @poll = Poll.find(params[:id])
      @poll.destroy
      redirect_to admin_polls_path, notice: "Enquete excluída."
    end

    def toggle_active
      @poll = Poll.find(params[:id])
      @poll.update(is_active: !@poll.is_active)
      redirect_to admin_polls_path, notice: "Status da enquete '#{@poll.question}' alterado."
    end

    private

    def poll_params
      params.require(:poll).permit(:question, :is_active)
    end
  end
end
