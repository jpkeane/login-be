module Api
  module V1
    class NewsController < ApiV1Controller
      before_action :set_news, only: [:show]

      def index
        @news = News.all
        render json: @news
      end

      def show
        render json: @news
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_news
        @news = News.find(params[:id])
      end
    end
  end
end
