module Api
  module V1
    class NewsController < ApiV1Controller
      skip_before_action :doorkeeper_authorize!, only: [:index, :show]
      before_action :set_news, only: [:show]

      def index
        @news = News.all
        render json: @news
      end

      def show
        render json: @news
      end

      # POST /news
      def create
        @news = News.new(news_params)

        if @news.save
          render json: @news, status: :created
        else
          render json: @news.errors, status: :unprocessable_entity
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_news
        @news = News.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def news_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
    end
  end
end
