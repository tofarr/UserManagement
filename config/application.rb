require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UserManagement
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.max_page_size = 20
    config.users_can_create_self = false
    config.users_can_update_self = true
    config.users_can_destroy_self = false # Protection against doing something stupid
    config.user_profiles_private = false # Users can view each other by default
    config.meta_public = false # Anonymous users don't get to view the meta
    config.user_profiles_public = false # Profiles can be viewed anonymously
  end
end
