# app/controllers/admin/poll_options_controller.rb

module Admin
  class PollOptionsController < Admin::ApplicationController
    before_action :set_poll # Garante que a enquete pai está carregada

    def new
      @poll_option = @poll.poll_options.new
    end

    def create
      @poll_option = @poll.poll_options.new(poll_option_params)
      if @poll_option.save
        redirect_to admin_poll_path(@poll), notice: "Opção de enquete criada com sucesso!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @poll_option = @poll.poll_options.find(params[:id])
    end

    def update
      @poll_option = @poll.poll_options.find(params[:id])
      if @poll_option.update(poll_option_params)
        redirect_to admin_poll_path(@poll), notice: "Opção de enquete atualizada com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @poll_option = @poll.poll_options.find(params[:id])
      @poll_option.destroy
      redirect_to admin_poll_path(@poll), notice: "Opção de enquete excluída."
    end

    private

    def set_poll
      @poll = Poll.find(params[:poll_id])
    end

    def poll_option_params
      params.require(:poll_option).permit(:option_text)
    end
  end
end
