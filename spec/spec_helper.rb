require 'rspec'
require 'omniauth'
require 'webmock/rspec'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

OmniAuth.config.logger.level = 4

