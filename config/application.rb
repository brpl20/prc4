require_relative 'boot'

require 'rails/all'

# Formato Brasileiro
Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M"
Date::DATE_FORMATS[:default] = "%d/%m/%Y"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Prc4
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths << "#{config.root}/app/models/filters"
    config.autoload_paths << "#{config.root}/app/models/services"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
