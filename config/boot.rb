require 'rubygems'
require 'bundler'
require "json"

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

Dotenv.overload ".env.#{ENV['RACK_ENV']}"

puts "Connecting DataBase..."
Sequel::Model.db = Sequel.connect(
  adapter: :postgres,
  user: ENV["POSTGRES_USER"],
  password: ENV["POSTGRES_PASSWORD"],
  host: ENV["POSTGRES_HOST"],
  port: ENV['POSTGRES_PORT'],
  max_connections: ENV["THREAD_COUNT"],
  database: "#{ENV['POSTGRES_DATABASE_BASE_NAME']}_#{ENV["RACK_ENV"]}"
)
puts "Connect Database complete."

Dir["./app/**/*.rb"].each { |file| require file }
