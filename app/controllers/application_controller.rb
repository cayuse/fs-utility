# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers. test

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a1ab868cf80aa62a93ad416894a5052a'
  before_action :authenticate_user!
  include Pundit
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
end
