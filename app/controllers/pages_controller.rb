class PagesController < ApplicationController
  after_filter :store_cache

  def about_me
  end
end
