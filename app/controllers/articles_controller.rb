class ArticlesController < ApplicationController
  before_filter :set_article, :only => [:show]
  after_filter :store_cache, :only => [:index, :show]

  def index
    @articles = search_articles.result(distinct: true).includes(:rubrics).page(params[:page] || 1).per(10)
    @rubrics = fetch_rubrics
  end

  def show
    @rubrics = @article.rubrics.inject({}){|hash, rubric| hash[rubric.id] = rubric.title; hash}
  end

  private

  def set_article
    @article = Article.includes(:rubrics).published.find(params[:id])
    if @article.language.to_sym != I18n.locale
      redirect_to @article.translation if @article.translation
      @translation_not_found = @article.translation.nil?
    end
  end

  def search_articles
    search_params = params[:rubric_id] ? (params[:q] || {}).merge(:rubrics_id_eq => params[:rubric_id]) : params[:q]
    @search_articles = Article.published.for_language(I18n.locale).order('updated_at DESC').search(search_params)
  end

  def fetch_rubrics
    Rails.cache.fetch CacheKey.all_rubrics_array do
      Rubric.for_language(I18n.locale).inject({}){|hash, rubric| hash[rubric.id] = rubric.title; hash}
    end
  end
end
