class ArticlesController < ApplicationController
  before_filter :set_article, :only => [:show]

  def index
    @search_articles = Article.includes(:rubrics).for_language(I18n.locale).order('updated_at DESC').search(params[:q])
    @articles = @search_articles.result(distinct: true).page(params[:page])
  end

  def show

  end

  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end
end
