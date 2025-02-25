ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)  # Rails 환경을 로드
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }
