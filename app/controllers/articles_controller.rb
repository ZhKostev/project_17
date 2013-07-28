class ArticlesController < ApplicationController
  before_filter :set_article, :only => [:show]

  def index
    Article.order('updated_at DESC').page(params[:page])
  end

  def show

  end

  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end
end
