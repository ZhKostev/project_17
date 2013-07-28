require 'spec_helper'

describe "rubrics/show" do
  before(:each) do
    @rubric = assign(:rubric, stub_model(Rubric,
      :title => "Title",
      :language => "Language",
      :translation_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Language/)
    rendered.should match(/1/)
  end
end
