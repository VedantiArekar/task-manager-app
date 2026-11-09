# GET /health
# Returns 200 when the app and the database are reachable, otherwise 503.
class HealthController < ActionController::API
  def show
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      connection.execute("SELECT 1")
    end

    render json: { status: "ok", database: "connected" }
  rescue StandardError => e
    Rails.logger.error("Health check failed: #{e.message}")
    render json: { status: "error", database: "disconnected" }, status: :service_unavailable
  end
end
