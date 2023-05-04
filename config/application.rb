# frozen_string_literal: true

# The main application class for the BloggersApp.

require_relative 'boot'

require 'rails/all'

require 'devise'

require 'view_component/engine'

# config.assets.enabled = true

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# # Bower asset paths
# config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

module BloggersApp
  class Application < Rails::Application
    # Bower asset paths
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

    config.autoload_paths << "#{Rails.root}/app/controllers"

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
