require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

# Require the gems listed in the Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaskManagerApp
  class Application < Rails::Application
    # Use the default settings of Rails 8.0
    config.load_defaults 8.0

    # Store timestamps in UTC
    config.time_zone = "UTC"

    # This app has both HTML pages and a JSON API, so it is not API-only
    config.api_only = false
  end
end
