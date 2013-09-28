class Admin::BaseController < ActionController::Base
  layout 'admin'

  before_filter :set_locale
  before_filter :authenticate_admin_user!

  def set_locale
    I18n.locale = :en
  end
end