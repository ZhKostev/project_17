# Public: Class with various methods to generate keys for cache
#
# Examples
#
#  CacheKey.article_short_body(Article.find(5))
#  #=> "article_5_rubrics"
class CacheKey
  class << self

    # Used for article body on index page.
    def article_short_body(article)
      "article_#{article.id}_body"
    end

    # Used for article's rubrics links on index page.
    def article_rubrics_line(article)
      "article_#{article.id}_rubrics"
    end

    # Used for right search part form
    def search_form_key
      "search_form_#{I18n.locale}"
    end

    # Used on left part on articles#show
    def article_body_html_for_show(article)
      "article_show_for_#{article.id}"
    end

    # Used on right part on articles#show
    def article_show_right_rubrics(article)
      "article_#{article.id}_rubrics_right_list"
    end

    # Used on right part on articles#index
    def all_rubrics(locale = I18n.locale)
      "all_rubrics_list_#{locale}"
    end

    # Used to store rubrics array for the language
    def all_rubrics_array(locale = I18n.locale)
      "all_rubrics_array_#{locale}"
    end

    # Used for 1 article on article#index
    def article_on_index(article)
      "article_#{article.id}_index_cache"
    end

    # Used for 1 page article#index
    def index_page_cache_key(params)
      prepared_params = params.reject { |k, v| %w(action controller locale page rubric_id).include?(k.to_s) }
      prepared_params.any? ? nil : "articles_index_#{params[:locale] || I18n.locale}#{'_' + params[:page].to_s if params[:page].to_i > 0}#{'_' + params[:rubric_id].to_s if params[:rubric_id]}"
    end

  end
end