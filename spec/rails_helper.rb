ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__) # Rails 환경을 로드
require 'rspec/rails'

Rails.root.glob('spec/support/**/*.rb').each { |file| require file }
