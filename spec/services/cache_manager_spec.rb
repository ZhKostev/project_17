require 'spec_helper'

describe CacheManager do

  describe '.cache_search_form' do
    it 'should not fetch cache if search params' do
      Rails.cache.should_not_receive(:fetch)
      CacheManager.cache_search_form({:q => 'search'}) { 5 }
    end

    it 'should not fetch cache if search params' do
      Rails.cache.should_receive(:fetch).with(CacheKey.search_form_key)
      CacheManager.cache_search_form({:controller => 'articles'}) { 5 }
    end
  end

  describe '.cache_rubrics_widget' do
    it 'should not fetch cache for all rubrics list' do
      Rails.cache.should_receive(:fetch).with(CacheKey.all_rubrics)
      CacheManager.cache_rubrics_widget({}) { 5 }
    end
  end

  describe '.cache_rubrics_widget' do
    it 'should not fetch cache if key could be build' do
      params = {}
      CacheKey.stub(:index_page_cache_key, params) { 'test_key' }
      Rails.cache.should_receive(:fetch).with('test_key')
      CacheManager.cache_index_page_articles(params) { 5 }
    end

    it 'should not fetch if key is nil' do
      params = {}
      CacheKey.stub(:index_page_cache_key, params) { nil }
      Rails.cache.should_not_receive(:fetch)
      CacheManager.cache_index_page_articles(params) { 5 }
    end
  end

  context 'with article' do
    let (:article) { stub_model Article, :id => 101 }

    describe '.cache_rubrics_for_article' do
      it 'should not fetch cache for rubrics' do
        Rails.cache.should_receive(:fetch).with(CacheKey.article_show_right_rubrics(article))
        CacheManager.cache_rubrics_for_article(article) { 5 }
      end
    end

    describe '.cache_article' do
      it 'should not fetch cache for all rubrics list' do
        Rails.cache.should_receive(:fetch).with(CacheKey.article_on_index(article))
        CacheManager.cache_article(article) { 5 }
      end
    end
  end

  describe '.expire_rubric_cache' do

    it 'should expire following cache' do
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
      rubric = stub_model Rubric, :language => 'sus', :id => 101
      articles = [stub_model(Article, :id => 35), stub_model(Article, :id => 36)]
      rubric.stub(:articles) { articles }
      #Rails.cache.should_not_receive(:delete)
      Article.stub_chain(:for_language, :count) { 11 }
      Rails.cache.should_receive(:delete).with(CacheKey.all_rubrics('sus')).ordered
      Rails.cache.should_receive(:delete).with(CacheKey.all_rubrics_array('sus')).ordered
      Rails.cache.should_receive(:delete).with(CacheKey.index_page_cache_key({:locale => 'sus'})).ordered
      Rails.cache.should_receive(:delete).with('/sus_global_cache').ordered
      Rails.cache.should_receive(:delete).with('/sus/articles_global_cache').ordered

      articles.each do |article|
        Rails.cache.should_receive(:delete).with(CacheKey.article_show_right_rubrics(article)).ordered
        Rails.cache.should_receive(:delete).with(CacheKey.article_rubrics_line(article)).ordered
        Rails.cache.should_receive(:delete).with(CacheKey.article_on_index(article)).ordered
        Rails.cache.should_receive(:delete).with(CacheKey.article_body_html_for_show(article)).ordered
        Rails.cache.should_receive(:delete).with("/#{article.language}/articles/#{article.id}_global_cache").ordered
      end

      3.times do |i|
        Rails.cache.should_receive(:delete).with(CacheKey.index_page_cache_key({:locale => 'sus', :page => i})).ordered
        Rails.cache.should_receive(:delete).with(CacheKey.index_page_cache_key({:locale => 'sus', :page => i, :rubric_id => 101})).ordered
      end

      Rails.cache.should_not_receive(:delete).ordered
      CacheManager.expire_rubric_cache(rubric)
    end
  end

  describe '.expire_article_cache' do
    pending 'Implement tests for article expiration mechanism'
  end

end
