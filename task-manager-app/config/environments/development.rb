require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Reload code on every request.
  config.enable_reloading = true
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true
  config.server_timing = true

  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  config.action_controller.raise_on_missing_callback_actions = true

  # Accept requests for any host name (needed later when the app runs in a
  # container and is reached through another address than "localhost").
  config.hosts.clear
end
