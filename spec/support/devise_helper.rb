module ControllerMacros
  def sign_in_admin
    before(:each) do
      sign_in FactoryGirl.create(:admin_user) # Using factory girl as an example
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
end
