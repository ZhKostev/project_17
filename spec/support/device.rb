require "#{Rails.root}/spec/support/sign_in_helper.rb"
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include SignInHelper, :type => :controller
end