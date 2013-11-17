require 'spec_helper'

describe PagesController do
  describe "GET 'about_me'" do
    it "returns http success for russian" do
      get 'about_me', {:locale => 'ru'}
      response.should be_success
    end

    it "returns http success for english" do
      get 'about_me', {:locale => 'ru'}
      response.should be_success
    end

    it 'should store cache' do
      controller.should_receive(:store_cache)
      get 'about_me', {:locale => 'ru'}
    end
  end
end
