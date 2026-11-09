module Api
  # Common behaviour for every JSON API controller.
  class BaseController < ActionController::API
    # Later handlers take priority, so the general database error comes first.
    rescue_from ActiveRecord::StatementInvalid, with: :database_error
    rescue_from ActiveRecord::ConnectionNotEstablished,
                ActiveRecord::ConnectionTimeoutError,
                ActiveRecord::NoDatabaseError,
                with: :database_unavailable
    rescue_from ActiveRecord::RecordNotFound, ActiveModel::RangeError, with: :record_not_found
    rescue_from ActionDispatch::Http::Parameters::ParseError, with: :invalid_json

    # Used by the catch-all route for unknown /api/... URLs
    def not_found
      render json: { error: "Endpoint not found" }, status: :not_found
    end

    private

    def record_not_found
      render json: { error: "Task not found" }, status: :not_found
    end

    def invalid_json
      render json: { error: "Invalid JSON body" }, status: :bad_request
    end

    def database_unavailable(error)
      Rails.logger.error("Database unavailable: #{error.message}")
      render json: { error: "Database unavailable" }, status: :service_unavailable
    end

    def database_error(error)
      Rails.logger.error("Database error: #{error.message}")
      render json: { error: "Database error" }, status: :internal_server_error
    end
  end
end
