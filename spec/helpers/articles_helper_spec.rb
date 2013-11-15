require 'spec_helper'

describe ArticlesHelper do
  describe '.coderay_wrapper' do
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
  end

  context 'with cache' do
    after(:each) do
      Rails.cache.clear
    end
    context 'with article for body generation' do
      let(:article) { stub_model Article, :id => 101, :title => 'test', :show_body => 'text' }

      describe '.article_html' do

        it 'should contain h3 with link' do
          helper.article_html(article).should include('<h3><a class="article_title" href="/ru/articles/101">test</a></h3>')
        end

        it 'should call methods for article truncated body and rubrics links' do
          helper.should_receive(:article_rubrics) { 'html' }
          helper.should_receive(:article_body) { 'html' }
          helper.article_html(article)
        end

        it 'should fetch article truncated body and rubrics links from cache' do
          Rails.cache.write CacheKey.article_short_body(article), 'test'
          Rails.cache.write CacheKey.article_rubric_line(article), 'test 2'
          helper.should_not_receive(:article_rubrics)
          helper.should_not_receive(:article_body)
          helper.article_html(article)
        end

        describe '.article_rubrics' do
          it 'should have clear block after' do
            helper.send(:article_rubrics, article).should include('<div class="clear"></div>')
          end

          it 'should include links to all rubrics' do
            rubric_1 = stub_model Rubric, :id => 1001, :title => 'title 1'
            rubric_2 = stub_model Rubric, :id => 1002, :title => 'title 2'
            article.stub(:rubrics) { [rubric_1, rubric_2] }
            result = helper.send(:article_rubrics, article)
            result.should include('<a class="article_rubric" href="/ru/articles?rubric_id=1001">title 1</a>')
            result.should include('<a class="article_rubric" href="/ru/articles?rubric_id=1002">title 2</a>')
          end
        end

        describe '.article_body' do
          it 'should have link to read more' do
            article.stub(:show_body) { 'DDD' }
            helper.send(:article_body, article).should include('Read more')
          end

          it 'should call short body on article' do
            article.stub(:show_body) { 'DDD' }
            helper.send(:article_body, article)
          end

          it 'should truncate text' do
            article.stub(:show_body) { '1234567890'*55 + 'NO TEXT' }
            result = helper.send(:article_body, article)
            result.should_not include('NO TEXT')
            result.should include('...')
          end
        end
      end

    end
  end
end
