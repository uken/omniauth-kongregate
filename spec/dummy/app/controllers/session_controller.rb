class SessionController < ActionController::Base
  skip_before_filter :verify_authenticity_token, :only => :callback
  protect_from_forgery :except => [:callback]

  def callback

  end
end
