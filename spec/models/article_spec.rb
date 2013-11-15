require 'spec_helper'

describe Article do
  describe '.show_body' do
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

    it 'should call expire_article_cache after save'  do
      article = FactoryGirl.create :article
      article.should_receive :expire_article_cache
      article.save
    end
  end

  describe '.expire_article_cache' do
    it 'should expire cache' do
      pending 'Implement cache expiration'
    end
  end
end
