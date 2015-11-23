ENV["RAILS_ENV"] ||= "development"

tag ENV["APP_NAME"] || "refsheet-admin"
daemonize false

port 9292
threads 1,6
workers 1

worker_timeout (ENV["RAILS_ENV"] == "development") ? 10_000 : 15

quiet

on_worker_boot do
  require "dotenv"
  Dotenv.load
end
