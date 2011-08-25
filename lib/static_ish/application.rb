module StaticIsh
  class Application
    def initialize(site)
      @site = site
    end
    
    def call(env)
      [200, {'Content-Type' => 'text/html'}, "<h1>Hello!</h1>"]
    end
  end
end