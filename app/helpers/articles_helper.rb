require 'coderay'
module ArticlesHelper

  # Public: Replace some article's html with styled html to show ruby code like in 'RubyMine'.
  # Keywords would be wraped in spans with special classes. For this purpose gem 'CodeRay' is used.
  #
  # Returns html
  def coderay_wrapper(text)
    text = text.gsub('&amp;lt;', '<').gsub('&amp;gt;', '>').gsub('&#39;', "'").gsub('&amp;', '&')
    result = text.gsub(/\<div lang="(.+?)"\>.+?\<pre\>(.+?)?\<\/pre\>\W*div\>/m) do
      content_tag("notextile", CodeRay.scan($2, $1).div(:css => :class).html_safe)
    end

    result.gsub('&amp;lt;', '<').gsub('&amp;gt;', '>').gsub('&amp;#39;', "'").gsub('&amp;quot;', '"').html_safe
  end

  # Public: Generate small block html for article index action. Cached parts are used.
  #
  # Returns html.
  def article_html(article)
    <<-HTML
      <div class="article_container">
        <h3>#{link_to article.title, article_path(article), :class => 'article_title'}</h3>
        #{(Rails.cache.fetch(CacheKey.article_short_body(article)) { article_rubrics(article) }).html_safe }
        #{(Rails.cache.fetch(CacheKey.article_rubric_line(article)) { article_body(article) }).html_safe }
      </div>
    HTML
  end

  private

  # Internal: Generate text for article short description. Method tries to use article's short
  # description. Text would be truncated to 550.
  #
  # Returns html/
  def article_body(article)
    stripped_body = strip_tags(article.show_body)

    truncate(stripped_body, :length => 550, :omission => "...  ") + ' ' + link_to(t('read_more'), article_path(article))
  end

  # Internal: Generate html for article's rubrics. Clickable boxes on article's index page
  #
  # Returns html.
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
