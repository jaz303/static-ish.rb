module StaticIsh
  class Application
    STATIC_INDEX = %w(index.htm index.html)
    
    def initialize(site)
      @site = site
      @root = site.public_root
      @file_server = Rack::File.new(@root, nil)
    end
    
    def call(env)
      path = env['PATH_INFO']
      try_static(env) || try_content(env)
    end
    
  private
  
    def try_static(env)
      candidates = [path]
      if File.directory?(File.join(@root, candidates[0]))
        if path[-1,1] != '/'
          response = Rack::Response.new
          response.redirect(path + '/')
          return response
        end
        candidates = STATIC_INDEX.map { |si| File.join(candidates[0], si) }
      end
      
      if (static_file = candidates.detect { |c| File.exists?(File.join(@root, c)) })
        return @file_server.call(env.update('PATH_INFO' => static_file)) # TODO: rewrite REQUEST_URI too?
      end
      
      nil
    end
    
    def try_content(env)
      [200, {'Content-Type' => 'text/html'}, "<h1>Hello!</h1>"]
    end
  end
end