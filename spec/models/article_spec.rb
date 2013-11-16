require 'spec_helper'

describe Article do
  it { should have_and_belong_to_many(:rubrics) }

  describe '#show_body' do
    it 'should return short_description if present' do
      article = stub_model Article, :short_description => 'MY TEST'
      article.show_body.should eq('MY TEST')
    end

    it 'should return body if short_description is not present' do
      article = stub_model Article, :short_description => '', :body => 'MY body'
      article.show_body.should eq('MY body')
    end
  end

  describe 'callbacks' do
    it 'should call expire_article_cache after create' do
      Article.any_instance.should_receive :expire_article_cache
      FactoryGirl.create :article
    end

    it 'should call expire_article_cache after save' do
      article = FactoryGirl.create :article
      article.should_receive :expire_article_cache
      article.save
    end
  end

  describe '#expire_article_cache' do
    it 'should call CacheManager.expire_rubric_cache' do
      article = stub_model Article
      CacheManager.should_receive(:expire_article_cache).with(article)
      article.send(:expire_article_cache)
    end
  end

  describe '.with_rubric' do
    it 'should fetch rubrics with exact article' do
      article_1 = FactoryGirl.create :article
      article_2 = FactoryGirl.create :article
      rubric_1 = FactoryGirl.create :rubric, :articles => [article_1, article_2]
      rubric_2 = FactoryGirl.create :rubric, :articles => [article_2]
      Article.with_rubric(rubric_2.id).order('id').should eq([article_2].sort_by { |article| article.id })
      Article.with_rubric(rubric_1.id).order('id').should eq([article_1, article_2].sort_by { |article| article.id })
    end
  end
end
