require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :title => "MyString",
      :body => "MyText",
      :translation_id => 1,
      :meta_description => "MyString",
      :published => false
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", article_path(@article), "post" do
      assert_select "input#article_title[name=?]", "article[title]"
      assert_select "textarea#article_body[name=?]", "article[body]"
      assert_select "input#article_translation_id[name=?]", "article[translation_id]"
      assert_select "input#article_meta_description[name=?]", "article[meta_description]"
      assert_select "input#article_published[name=?]", "article[published]"
    end
  end
end
