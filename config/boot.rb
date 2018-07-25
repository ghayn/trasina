require 'rubygems'
require 'bundler'
require "json"

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

puts "Connect Postgres DB..."
Sequel::Model.db = Sequel.connect(
  adapter: :postgres,
  user: ENV["POSTGRES_USER"],
  password: ENV["POSTGRES_PASSWORD"],
  host: 'db',
  port: ENV['POSTGRES_PORT'],
  max_connections: ENV["THREAD_COUNT"],
  database: "#{ENV['POSTGRES_DATABASE_BASE_NAME']}_#{ENV["RACK_ENV"]}"
)
puts "Connect Postgres DB complete."

Dotenv.load ".env.#{ENV['RACK_ENV']}"

Dir["./app/**/*.rb"].each { |file| require file }
