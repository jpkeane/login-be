module Api
  module V1
    class UsersController < ApiV1Controller
      skip_before_action :doorkeeper_authorize!, only: [:create]
      before_action :set_user, only: [:show, :update]

      before_action :check_forbidden_changes, only: [:update]

      def index
        @users = User.all
        authorize @users

        render json: @users
      end

      def show
        authorize @user
        render json: @user
      end

      # POST /user
      def create
        @user = User.new(user_params)

        authorize @user
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH /user/:id
      def update
        authorize @user

        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def check_forbidden_changes
        username = user_params[:username]
        return if username.blank? || username == @user.username
        render json: { error: 'Cannot change username' }, status: :unprocessable_entity
      end
    end
  end
end
