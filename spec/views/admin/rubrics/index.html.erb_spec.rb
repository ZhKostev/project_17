require 'spec_helper'

describe "rubrics/index" do
  before(:each) do
    assign(:rubrics, [
      stub_model(Rubric,
        :title => "Title",
        :language => "Language",
        :translation_id => 1
      ),
      stub_model(Rubric,
        :title => "Title",
        :language => "Language",
        :translation_id => 1
      )
    ])
  end

  it "renders a list of rubrics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
