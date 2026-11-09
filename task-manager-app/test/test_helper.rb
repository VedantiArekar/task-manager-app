ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"

# Safety check: never run the tests against the development database.
test_database = ActiveRecord::Base.connection_db_config.database.to_s
unless test_database.end_with?("_test")
  abort "Refusing to run tests on database '#{test_database}'. " \
        "Create a .env.test file with a DATABASE_URL that ends in a name like 'taskmanager_test' " \
        "(see .env.test.example)."
end

require "rails/test_help"
