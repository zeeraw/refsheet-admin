require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
    end

    config.lograge.enabled = true
    config.lograge.custom_options = lambda do |event|
      params = event.payload[:params].reject do |k|
        %w(controller action).include? k
      end
      { "params" => params }
    end

  end
end
