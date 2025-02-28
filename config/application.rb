require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Saigen
  
  class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
      root_path
    end
  end

  class Application < Rails::Application
    require_relative "boot"

    require "rails/all"
    
    Bundler.require(*Rails.groups)
    
    module TechLogApp
      class Application < Rails::Application
        config.load_defaults 7.0
        config.i18n.default_locale = :ja
    
        config.generators do |g|
          g.assets false
          g.helper     false
          g.test_framework :rspec, 
            fixtures: false, 
            view_specs: false, 
            helper_specs: false, 
            routing_specs: false 
        end
      end
    end
  end
end
