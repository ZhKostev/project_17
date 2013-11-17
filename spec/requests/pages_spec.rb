require 'spec_helper'

describe "Pages" do
  describe "GET /ru/about_me" do
    it "should respond with middleware if cache present" do
      Rails.cache.write '/ru/about_me_global_cache', 'MY CACHE.'
      get about_me_path(:locale => 'ru', :id => 'about_me')
      response.status.should be(200)
      expect(response.body).to include("MY CACHE.")
      Rails.cache.delete '/ru/about_me_global_cache'
    end

    it "should respond with middleware even if params present" do
      Rails.cache.write '/ru/about_me_global_cache', 'MY CACHE.'
      get about_me_path(:locale => 'ru', :id => 'about_me', :qas => 'test')
      response.status.should be(200)
      expect(response.body).to include("MY CACHE.")
      Rails.cache.delete '/ru/about_me_global_cache'
    end
  end
end