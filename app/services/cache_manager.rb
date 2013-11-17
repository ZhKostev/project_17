class CacheManager
  class << self

    # Cache right search form
    def cache_search_form(params)
      if params[:q]
        yield
      else
        Rails.cache.fetch CacheKey.search_form_key do yield end
      end
    end

    # Cache article body html with title for articles#show page
    def cache_article_show(article)
      Rails.cache.fetch CacheKey.article_body_html_for_show(article) do yield end
    end

    # Cache right part of article show page (rubrics)
    def cache_rubrics_for_article(article)
      Rails.cache.fetch CacheKey.article_show_right_rubrics(article) do yield end
    end

    # Cache right part with all rubrics on articles#index
    def cache_rubrics_widget(params)
      Rails.cache.fetch CacheKey.all_rubrics do yield end
    end

    # Cache 1 article on article#index
    def cache_article(article)
      Rails.cache.fetch CacheKey.article_on_index(article) do yield end
    end

    # Cache one of the articles#index pages
    def cache_index_page_articles(params)
      if (key = CacheKey.index_page_cache_key(params))
        Rails.cache.fetch(key) do yield end
      else
        yield
      end
    end


    # Public: Method will expire cache for the rubric. Method will expire
    # - right list on index page
    # - right array for list on index page
    # - article index for rubric language
    # - root page global cache if rubric language is russian
    # - root page global cache for rubric language
    # - article index global cache for rubric language
    #
    # - right rubric list for all related articles
    # - index rubric line for all related articles
    # - index cache for all related articles
    # - show body cache for all related articles
    # - show global cache for all related articles
    # -
    # - index cache for all possible pages for rubric language and rubric id
    # - index cache for all possible pages for rubric language without rubric id
    #
    # Returns nothing
    def expire_rubric_cache(rubric)
      Rails.cache.delete CacheKey.all_rubrics(rubric.language)
      Rails.cache.delete CacheKey.all_rubrics_array(rubric.language)
      Rails.cache.delete CacheKey.index_page_cache_key({:locale => rubric.language})
      Rails.cache.delete "/_global_cache" if rubric.language == I18n.default_locale.to_s
      Rails.cache.delete "/#{rubric.language}_global_cache"
      Rails.cache.delete "/#{rubric.language}/articles_global_cache"

      rubric.articles.each do |article|
        Rails.cache.delete CacheKey.article_show_right_rubrics(article)
        Rails.cache.delete CacheKey.article_rubrics_line(article)
        Rails.cache.delete CacheKey.article_on_index(article)
        Rails.cache.delete CacheKey.article_body_html_for_show(article)
        Rails.cache.delete "/#{article.language}/articles/#{article.id}_global_cache"
      end
      #remove index cache for rubric
      (Article.for_language(rubric.language).count / 10 + 2).times do |page_number|
        Rails.cache.delete CacheKey.index_page_cache_key({:locale => rubric.language, :page => page_number})
        Rails.cache.delete CacheKey.index_page_cache_key({:locale => rubric.language, :page => page_number, :rubric_id => rubric.id})
      end
    end

    # Public: Method will expire cache for the article. Method will expire
    # - article index show part
    # - article index body part
    # - article show title & body
    # -
    # -
    # - article show global cache
    # - articles index global cache if language is default
    # - articles index for article language global cache
    # - articles index for article language all rubrics and pages index global cache
    #
    # Returns nothing
    def expire_article_cache(article)
      Rails.cache.delete CacheKey.article_on_index(article)
      Rails.cache.delete CacheKey.article_short_body(article)
      Rails.cache.delete CacheKey.article_body_html_for_show(article)
      Rails.cache.delete "/#{article.language}_global_cache"
      Rails.cache.delete "/#{article.language}/articles/#{article.id}_global_cache"
      Rails.cache.delete "/_global_cache" if article.language == I18n.default_locale.to_s
      (Article.for_language(article.language).count / 10 + 2).times do |page_number|
        Rails.cache.delete CacheKey.index_page_cache_key({:locale => article.language, :page => page_number})
        (Rubric.for_language(article.language).pluck(:id) + [nil]).each do |rubric_id|
          Rails.cache.delete CacheKey.index_page_cache_key({:locale => article.language, :page => page_number, :rubric_id => rubric_id})
        end
      end
    end
  end
end