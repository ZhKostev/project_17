require 'coderay'
module ArticlesHelper
  def coderay_wrapper(text)
    text.gsub(/\<div( lang="(.+?)")?\>.+\<pre\>(.+?)\<\/pre\>.+\<\/div\>/m) do
      content_tag("notextile", CodeRay.scan($3, $2).div(:css => :class).html_safe)
    end.html_safe.gsub('&amp;lt;','<').gsub('&amp;gt;','>').html_safe
  end
end
