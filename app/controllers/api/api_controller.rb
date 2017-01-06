module Api
  class ApiController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def not_found
      head 404
    end
  end
end
