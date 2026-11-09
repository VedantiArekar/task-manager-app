require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = ENV["CI"].present?

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Render exception templates for rescuable exceptions and raise for other exceptions.
  config.action_dispatch.show_exceptions = :rescuable

  # Disable CSRF protection in the test environment.
  config.action_controller.allow_forgery_protection = false

  config.active_support.deprecation = :stderr
  config.action_controller.raise_on_missing_callback_actions = true
end
