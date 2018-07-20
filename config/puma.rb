threads_count = ENV.fetch("MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count
port ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
