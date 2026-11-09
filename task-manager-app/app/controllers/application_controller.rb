class ApplicationController < ActionController::Base
  # Later handlers take priority, so the general database error comes first.
  rescue_from ActiveRecord::StatementInvalid, with: :database_error
  rescue_from ActiveRecord::ConnectionNotEstablished,
              ActiveRecord::ConnectionTimeoutError,
              ActiveRecord::NoDatabaseError,
              with: :database_unavailable
  rescue_from ActiveRecord::RecordNotFound, ActiveModel::RangeError, with: :task_not_found
  rescue_from ActionController::ParameterMissing, with: :bad_form

  private

  def task_not_found
    redirect_to tasks_path, alert: "Task not found."
  end

  def bad_form
    redirect_to tasks_path, alert: "The form was incomplete. Please try again."
  end

  def database_unavailable(error)
    Rails.logger.error("Database unavailable: #{error.message}")
    @title = "Database unavailable"
    @message = "The application cannot connect to PostgreSQL. " \
               "Check that the database is running and that DATABASE_URL is correct."
    render "errors/database", status: :service_unavailable
  end

  def database_error(error)
    Rails.logger.error("Database error: #{error.message}")
    @title = "Database error"
    @message = "A database error occurred. Make sure the migrations have been run " \
               "(bundle exec rails db:migrate)."
    render "errors/database", status: :internal_server_error
  end
end
