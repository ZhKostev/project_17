class Admin::BaseController < ActionController::Base
  layout 'admin'

  before_filter :authenticate_admin_user!
  before_action :set_locale

  def set_locale
    I18n.locale = :en
  end
end