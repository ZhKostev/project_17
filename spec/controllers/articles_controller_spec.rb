require 'spec_helper'

describe ArticlesController do

  describe 'index page' do
    before(:all) do
      @rubric_1 = FactoryGirl.create :rubric, :title => 'my interests', :language => 'ru'
      @rubric_2 = FactoryGirl.create :rubric, :title => 'tricks', :language => 'ru'
      @article_1 = FactoryGirl.create :article, :title => 'First', :short_description => 'NNN', :body => 'AAA',
                                      :language => 'ru', :rubrics => [@rubric_1, @rubric_2]
      @article_2 = FactoryGirl.create :article, :title => 'Second', :short_description => 'MMM', :body => 'BBB',
                                      :language => 'ru', :rubrics => [@rubric_1]
    end

    it 'should assign articles and rubrics' do
      get :index
      assigns(:articles).order('id').to_a.should eq([@article_1, @article_2])
      assigns(:rubrics).should be_any
    end

    it 'should find articles by title' do
      get :index, {:q => {:title_or_rubrics_title_or_body_or_short_description_cont => 'First'}}
      assigns(:articles).order('id').to_a.should eq([@article_1])
    end

    it 'should find articles by body' do
      get :index, {:q => {:title_or_rubrics_title_or_body_or_short_description_cont => 'MMM'}}
      assigns(:articles).order('id').to_a.should eq([@article_2])
    end

    it 'should find articles by short description' do
      get :index, {:q => {:title_or_rubrics_title_or_body_or_short_description_cont => 'NNN'}}
      assigns(:articles).order('id').to_a.should eq([@article_1])
    end

    it 'should find articles by rubric title' do
      get :index, {:q => {:title_or_rubrics_title_or_body_or_short_description_cont => 'tricks'}}
      assigns(:articles).order('id').to_a.should eq([@article_1])
    end

    it 'should find articles by rubric id' do
      get :index, {:rubric_id => @rubric_1.id}
      assigns(:articles).order('id').to_a.should eq([@article_1, @article_2])
    end

    it 'should find articles by rubric id with search params' do
      get :index, {:rubric_id => @rubric_1.id, :q => {:title_or_rubrics_title_or_body_or_short_description_cont => 'MMM'}}
      assigns(:articles).order('id').to_a.should eq([@article_2])
    end

    it 'should store cache' do
      controller.should_receive(:store_cache)
      get :index
    end
  end

  describe 'store_cache before_filer' do
    it 'should write a cache' do
      Rails.cache.clear
      Rails.cache.should_receive(:fetch) { {} }
      Rails.cache.should_receive(:write).with('/ru/articles_global_cache', anything())
      get :index, {:locale => :ru}
    end

    it 'should not write a cache id some params present' do
      Rails.cache.should_not_receive(:write).with('/ru/articles_global_cache')
      get :index, {:other_param => 'asd'}
    end
  end

  describe 'show page' do

    context 'with random article' do
      let(:article) { FactoryGirl.create :article }
      it 'should store cache' do
        controller.should_receive(:store_cache)
        get :show, {:locale => 'ru', :id => article.id}
      end

      it 'should find article. This article should include rubrics' do
        Article.should_receive(:includes) { Article }
        get :show, {:locale => article.language, :id => article.id}
        assigns(:article).should eq(article)
        assigns(:rubrics).should_not be_nil
      end
    end

    it 'should redirect to translation if current locale is wrong for article' do
      article_translation = FactoryGirl.create :article, :language => 'en'
      article = FactoryGirl.create :article, :language => 'ru', :translation_id => article_translation.id
      get :show, {:locale => :en, :id => article.id}
      response.should be_redirect
    end

    it 'should set @translation_not_found if current locale is wrong for article and no translation is present' do
      article = FactoryGirl.create :article, :language => 'ru'
      get :show, {:locale => :en, :id => article.id}
      response.should be_success
      assigns(:article).should eq(article)
      assigns(:rubrics).should_not be_nil
      assigns(:translation_not_found).should eq(true)
    end

  end
end
