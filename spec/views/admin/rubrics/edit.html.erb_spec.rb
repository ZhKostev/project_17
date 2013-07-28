require 'spec_helper'

describe "rubrics/edit" do
  before(:each) do
    @rubric = assign(:rubric, stub_model(Rubric,
      :title => "MyString",
      :language => "MyString",
      :translation_id => 1
    ))
  end

  it "renders the edit rubric form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rubric_path(@rubric), "post" do
      assert_select "input#rubric_title[name=?]", "rubric[title]"
      assert_select "input#rubric_language[name=?]", "rubric[language]"
      assert_select "input#rubric_translation_id[name=?]", "rubric[translation_id]"
    end
  end
end
