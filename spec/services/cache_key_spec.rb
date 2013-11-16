require 'spec_helper'

describe CacheKey do

  context 'with article' do
    let (:article) { stub_model Article, :id => 101 }

    it 'should generate article key' do
      CacheKey.article_short_body(article).should eq('article_101_body')
    end

    it 'should generate article key' do
      CacheKey.article_rubrics_line(article).should eq('article_101_rubrics')
    end

    it 'should generate article show page body key' do
      CacheKey.article_body_html_for_show(article).should eq('article_show_for_101')
    end

    it 'should generate cache key for article show rubric part' do
      CacheKey.article_show_right_rubrics(article).should eq('article_101_rubrics_right_list')
    end

    it 'should generate cache key for 1 article on articles#index' do
      CacheKey.article_on_index(article).should eq('article_101_index_cache')
    end
  end

  context 'with strange locale' do
    before(:each) do
      I18n.locale = 'sus'
    end

    it 'should generate search form key for language' do
      CacheKey.search_form_key.should eq('search_form_sus')
    end

    it 'should generate key for all rubric list rely on language' do
      CacheKey.all_rubrics.should eq('all_rubrics_list_sus')
    end

    it 'should generate key for all rubric list rely on language' do
      CacheKey.all_rubrics.should eq('all_rubrics_list_sus')
    end
    it 'should generate key for all rubric array rely on language' do
      'all_rubrics_array_sus'
    end
  end

  describe '.index_page_cache_key' do
    it 'should return nil if search params present' do
      CacheKey.index_page_cache_key({:q => 'test'}).should be_nil
    end

    it 'should create complex key with rubric, page and language' do
      I18n.locale = 'sus'
      params = {:action => 'index', :controller => 'articles', :locale => 'en', :page => 2, :rubric_id => 7}
      CacheKey.index_page_cache_key(params).should eq('articles_index_en_2_7')
    end

    it 'should use I18n.locale id params locale blank' do
      I18n.locale = 'sus'
      params = {:action => 'index', :controller => 'articles', :page => 2, :rubric_id => 7}
      CacheKey.index_page_cache_key(params).should eq('articles_index_sus_2_7')
    end
  end

end