# app/controllers/admin/news_posts_controller.rb
module Admin
  class NewsPostsController < Admin::ApplicationController
    before_action :set_news_post, only: %i[ edit update destroy ]

    def index
      @news_posts = NewsPost.all
    end

    # GET /admin/news_posts/new
    def new
      @news_post = NewsPost.new
    end

    # GET /admin/news_posts/1/edit
    def edit
    end

    # POST /admin/news_posts
    def create
      @news_post = NewsPost.new(news_post_params)

      if @news_post.save
        redirect_to admin_news_posts_path, notice: "Novidade criada com sucesso!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/news_posts/1
    def update
      if @news_post.update(news_post_params)
        redirect_to admin_news_posts_path, notice: "Novidade atualizada com sucesso!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/news_posts/1
    def destroy
      @news_post.destroy
      redirect_to admin_news_posts_path, notice: "Novidade excluída."
    end

    private
      # Usa callbacks para compartilhar lógica comum
      def set_news_post
        @news_post = NewsPost.find(params[:id])
      end

      # Apenas permite uma lista de parâmetros confiáveis
      def news_post_params
        params.require(:news_post).permit(:titulo, :conteudo, :data_publicacao, :photo)
      end
  end
end
