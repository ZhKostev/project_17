class ArticlesController < ApplicationController
  before_filter :set_article, :only => [:show]

  def index
    search_params = params[:rubric_id] ? (params[:q] || {}).merge(:rubrics_id_eq => params[:rubric_id]) : params[:q]
    @search_articles = Article.for_language(I18n.locale).order('updated_at DESC').search(search_params)
    all_articles = @search_articles.result(distinct: true).includes(:rubrics)
    @articles = all_articles.page(params[:page])
    @rubrics = Rubric.select('DISTINCT rubrics.*').for_articles(all_articles)
  end

  def show

  end

  private

  def set_article
    @article = Article.friendly.find(params[:id])
  end
end
