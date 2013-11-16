require 'spec_helper'

describe PagesController do
  describe "GET 'index'" do
    it "returns http success for russian" do
      get 'about_me', {:locale => 'ru'}
      response.should be_success
    end

    it "returns http success for english" do
      get 'about_me', {:locale => 'ru'}
      response.should be_success
    end
  end
end
