module Api
  module V1
    class ApiV1Controller < Api::ApiController
      include Pundit

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      before_action :doorkeeper_authorize!
      after_action :verify_authorized

      def current_user
        @current_user ||= _doorkeeper_user
      end

      def _doorkeeper_user
        return unless valid_doorkeeper_token?

        User.find(doorkeeper_token.resource_owner_id)
      end

      private

      def user_not_authorized
        head 403
      end

      def not_found
        head 404
      end
    end
  end
end
