require 'coderay'
module ArticlesHelper
  def coderay_wrapper(text)
    text = text.gsub('&amp;lt;','<').gsub('&amp;gt;','>').gsub('&#39;',"'").gsub('&amp;','&')
    result = text.gsub(/\<div lang="(.+?)"\>.+?\<pre\>(.+?)?\<\/pre\>\W*div\>/m) do
      content_tag("notextile", CodeRay.scan($2, $1).div(:css => :class).html_safe)
    end

    result.gsub('&amp;lt;','<').gsub('&amp;gt;','>').gsub('&amp;#39;',"'").gsub('&amp;quot;','"').html_safe
  end

  def article_html(article)
    <<-HTML
      <div class="article_container">
        <h3>#{link_to article.title, article_path(article), :class => 'article_title'}</h3>
        #{(Rails.cache.fetch("article_#{article.id}_rubrics") {article_rubrics(article)}).html_safe }
        #{(Rails.cache.fetch("article_#{article.id}_body") {article_body(article)}).html_safe }
      </div>
    HTML
  end
  
  private
  
  def article_body(article)
    stripped_body = strip_tags(article.show_body)
      truncate(stripped_body, :length => 550, :omission => "...  ") +
          (stripped_body.length > 550 ? link_to(t('read_more'), article_path(article)): '')
  end
  
  def article_rubrics(article)
    result = ''
    if article.rubrics.any?
      article.rubrics.each do |rubric|
        result += link_to rubric.title, articles_path({:rubric_id => rubric.id}), :class => 'article_rubric'
      end
    end

    result + '<div class="clear"></div>'
  end
  
end
