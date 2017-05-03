require_relative 'boot'

# require 'rails/all'


require "action_controller/railtie"
require "action_mailer/railtie"
#require "active_resource/railtie" no need
#require "rails/test_unit/railtie" no need
#require "sprockets/railtie" no need

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageBuilder
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
