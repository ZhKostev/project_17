class CacheManager
  class << self

    def cache_index_page_articles(params)
      if (key = index_page_cache_key(params))
        Rails.cache.fetch key do
          yield
        end
      else
        yield
      end
    end

    def cache_article_show(article)
      Rails.cache.fetch "article_show_for_#{article.id}" do
         yield
      end
    end

    def cache_search_form(params)
      if params[:q]
        yield
      else
        Rails.cache.fetch "search_form_#{I18n.locale}" do
          yield
        end
      end
    end

    def cache_rubrics_for_article(article)
      Rails.cache.fetch "article_#{article.id}_rubrics_right_list" do
        yield
      end
    end

    def cache_rubrics_widget(params)
      Rails.cache.fetch 'all_rubrics_list' do
        yield
      end
    end

    def cache_article(article)
      Rails.cache.fetch "article_index_cache_#{article.id}" do
        yield
       end
    end


    def expire_rubric_cache(rubric)
      Rails.cache.delete 'all_rubrics'
      Rails.cache.delete 'all_rubrics_list'
      Rails.cache.delete "articles_index_#{rubric.language}"
      rubric.articles.each do |article|
        Rails.cache.delete "article_#{article.id}_rubrics"
        Rails.cache.delete "article_#{article.id}_rubrics_right_list"
        Rails.cache.delete "article_index_cache_#{article.id}"
      end
      #remove index cache for rubric
      (Article.for_language(rubric.language).count / 10 + 1).times do |page_number|
        Rails.cache.delete "articles_index_#{rubric.language}#{'_' + page_number.to_s if page_number > 0}_#{rubric.id}"
      end
    end

    def expire_article_cache(article)
      Rails.cache.delete "article_show_for_#{article.id}"
      Rails.cache.delete "article_index_cache_#{article.id}"
      language = article.language
      (Article.for_language(language).count / 10 + 1).times do |page|
        (Rubric.pluck(:id) + [nil]).each do |rubric_id|
          Rails.cache.delete "articles_index_#{language}#{'_' + page.to_s if page > 0}#{'_' + rubric_id.to_s if rubric_id}"
        end
      end
    end

    private

    def index_page_cache_key(params)
      prepared_params = params.reject{|k,v| %w(action controller locale page rubric_id).include?(k)}
      prepared_params.any? ? nil : "articles_index_#{I18n.locale}#{'_' + params[:page] if params[:page]}#{'_' + params[:rubric_id] if params[:rubric_id]}"
    end
  end
end