class Admin::BaseController < ActionController::Base
  layout 'admin'

  before_filter :authenticate_admin_user!
end