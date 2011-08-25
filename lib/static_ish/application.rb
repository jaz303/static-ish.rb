module StaticIsh
  class Application
    STATIC_INDEX = %w(index.htm index.html)
    
    def initialize(site)
      @site = site
      @root = site.public_root
      @file_server = Rack::File.new(@root, nil)
    end
    
    def call(env)
      try_static(env)
        || try_content(env)
        || [404, {'Content-Type' => 'text/html'}, "<h1>404 Page Not Found</h1>"]
    end
    
  private
  
    def try_static(env)
      path = env['PATH_INFO']
      if File.directory?(File.join(@root, path))
        if path[-1,1] != '/'
          response = Rack::Response.new
          response.redirect(path + '/')
          return response
        end
        candidates = STATIC_INDEX.map { |si| File.join(path, si) }
      else
        candidates = [path]
      end
      
      if (static_file = candidates.detect { |c| File.exists?(File.join(@root, c)) })
        return @file_server.call(env.update('PATH_INFO' => static_file)) # TODO: rewrite REQUEST_URI too?
      end
      
      nil
    end
    
    def try_content(env)
      if page = @site[env['PATH_INFO']]
        
      else
        nil
      end
    end
  end
end