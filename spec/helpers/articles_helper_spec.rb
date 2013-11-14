require 'spec_helper'

describe ArticlesHelper do
  it 'should replace html with formated for ruby code' do
    html = <<-HTML
      <p> My article <p>
      <div lang="ruby">
      <pre>
        class A
        end
      </pre>
      <div>
      </p> My article's end</p>
    HTML

    expected_result = <<-HTML
      <p> My article <p>
      <notextile>
        <div class=\"CodeRay\">
            <div class=\"code\">
              <pre>
                <span class=\"keyword\">class</span> <span class=\"class\">A</span>
                <span class=\"keyword\">end</span>
              </pre>
          </div>
        </div>
      </notextile>
      </p> My article's end</p>
    HTML

    coderay_wrapper(html).gsub(/\s/, '').should eq(expected_result.gsub(/\s/, ''))
  end

  context 'article body generation' do

  end
end
