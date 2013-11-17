require 'spec_helper'

describe "Articles" do
  describe "GET /ru/articles" do
    it "should respond with middleware if cache present" do
      Rails.cache.write '/ru/articles_global_cache', 'INDEX CACHE.'
      get articles_path
      response.status.should be(200)
      expect(response.body).to include("INDEX CACHE.")
      Rails.cache.delete '/ru/articles_global_cache'
    end

    it "should not respond with middleware if params present" do
      Rails.cache.write '/ru/articles_global_cache', 'INDEX CACHE.'
      get articles_path, {:qas => 'test'}
      response.status.should be(200)
      expect(response.body).to_not include("INDEX CACHE.")
      Rails.cache.delete '/ru/articles_global_cache'
    end
  end

  describe "GET /ru/articles/101" do
    it "should respond with middleware if cache present" do
      Rails.cache.write '/ru/articles/101_global_cache', 'SHOW CACHE.'
      get article_path(101)
      response.status.should be(200)
      expect(response.body).to include("SHOW CACHE.")
      Rails.cache.delete '/ru/articles/101_global_cache'
    end

    it "should not respond with middleware if params present" do
      article = FactoryGirl.create :article
      Rails.cache.write "/ru/articles/#{article.id}_global_cache", 'SHOW CACHE.'
      get article_path(article), {:qas => 'test'}
      response.status.should be(200)
      expect(response.body).to_not include("SHOW CACHE.")
      Rails.cache.delete "/ru/articles/#{article.id}_global_cache"
    end
  end
end
