require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store

  # The CSS and JavaScript files live in /public, so Rails serves them itself.
  config.public_file_server.enabled = true

  # SSL is not forced because TLS is normally handled in front of the app.
  config.force_ssl = false

  # Log to STDOUT (works well with containers and `docker logs`).
  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.logger($stdout)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false

  # The secret key is read from the SECRET_KEY_BASE environment variable.
end
