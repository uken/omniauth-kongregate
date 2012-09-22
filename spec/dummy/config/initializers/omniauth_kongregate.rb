puts 'starting K'
require 'omniauth-kongregate'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :kongregate, 'YOUR_API_KEY_GOES_HERE_SEE_README'
end
