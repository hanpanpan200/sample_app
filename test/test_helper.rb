ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  #whether the current user is logged in?
  #I don't understand the session[:user_id] here,why the tutorial says it is a method?
  #how can this work? 2015-5-19
  def is_logged_in?
    !session[:user_id].nil?
  end
end
