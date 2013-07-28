require 'spec_helper'

describe "rubrics/new" do
  before(:each) do
    assign(:rubric, stub_model(Rubric,
      :title => "MyString",
      :language => "MyString",
      :translation_id => 1
    ).as_new_record)
  end

  it "renders new rubric form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rubrics_path, "post" do
      assert_select "input#rubric_title[name=?]", "rubric[title]"
      assert_select "input#rubric_language[name=?]", "rubric[language]"
      assert_select "input#rubric_translation_id[name=?]", "rubric[translation_id]"
    end
  end
end
