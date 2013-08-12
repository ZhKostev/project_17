class PagesController < ApplicationController
  def about_me
    render "#{I18n.locale}_about_me"
  end
end
