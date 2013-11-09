class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    options.merge({:locale => I18n.locale})
  end

  def store_cache
    if params.except('action', 'controller', 'locale', 'id').empty? && !Rails.cache.exist?("#{request.path}_global_cache")
      Rails.cache.write "#{request.path}_global_cache", response.body
    end
  end
end
