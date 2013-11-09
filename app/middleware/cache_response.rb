module Middleware
  class CacheResponse
    def initialize(application)
      @application = application
    end

    def call(environment)
      request = Rack::Request.new(environment)
      url = request.url
      action_params = Rails.application.routes.recognize_path(url) rescue {}
      if use_cache_condition(action_params, url) && (body = Rails.cache.read "#{request.path}_global_cache")
        [200,
         {'ETag' => Base64.encode64('request.url'),
          'Content-Type' => 'text/html; charset=utf-8',
          'Cache-Control' => "max-age=86400, must-revalidate"}, [body]]
      else
        @application.call(request.env)
      end

    end


    def use_cache_condition(action_params, request_url)
      (action_params[:controller] == 'pages' && action_params[:action] == 'about_me') ||
          (action_params[:controller] == 'articles' && %(index show).include?(action_params[:action]) && !(request_url =~ /\?/))
    end
  end
end