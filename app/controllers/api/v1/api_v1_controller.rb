module Api
  module V1
    class ApiV1Controller < Api::ApiController
      def current_user
        @current_user ||= _doorkeeper_user
      end

      def _doorkeeper_user
        return unless valid_doorkeeper_token?

        User.find(doorkeeper_token.resource_owner_id)
      end
    end
  end
end
