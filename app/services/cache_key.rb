# Public: Class with various methods to generate keys for cache
#
# Examples
#
#  CacheKey.article_short_body(Article.find(5))
#  #=> "article_5_rubrics"
class CacheKey
  class << self

    # Used for article body on index page.
    def article_short_body(article)
      "article_#{article.id}_rubrics"
    end

    # Used for article's rubrics links on index page.
    def article_rubric_line(article)
      "article_#{article.id}_body"
    end
  end
end