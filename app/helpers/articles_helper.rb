require 'coderay'
module ArticlesHelper
  def coderay_wrapper(text)
    text = text.gsub('&amp;lt;','<').gsub('&amp;gt;','>').gsub('&#39;',"'").gsub('&amp;','&')
    result = text.gsub(/\<div lang="(.+?)"\>.+?\<pre\>(.+?)?\<\/pre\>\W*div\>/m) do
      content_tag("notextile", CodeRay.scan($2, $1).div(:css => :class).html_safe)
    end

    result.gsub('&amp;lt;','<').gsub('&amp;gt;','>').gsub('&amp;#39;',"'").gsub('&amp;quot;','"').html_safe
  end

end
