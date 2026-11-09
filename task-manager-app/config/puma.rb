# Puma web server configuration.

max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Port comes from the PORT environment variable (default 3000)
port ENV.fetch("PORT", 3000)

# Allow `rails restart` to restart Puma
plugin :tmp_restart

# Run the Puma master process in the foreground (no daemon)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
