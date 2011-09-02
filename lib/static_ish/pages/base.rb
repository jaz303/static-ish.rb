module StaticIsh
  module Pages
    class Base
      attr_reader :site         # site to which this page belongs
      attr_reader :path         # absolute FS path to this page
      attr_reader :parts        # array of page parts
      
      attr_accessor :url        # page URL
      attr_accessor :parent     # parent page
      
      def [](k);      @preamble[k.to_sym];          end
      def []=(k,v);   @preamble[k.to_sym] = v;      end
      
      def initialize(site, path, preamble = {}, parts = [])
        preamble = preamble.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
        @site, @path, @preamble, @parts = site, path, preamble, parts
        @children = {}
      end
      
      def type
        @type ||= @site.registry.page_type(self)
      end
      
      def part(ix)
        part.is_a?(Fixnum) ? parts[ix] : (parts.find { |p| p.id == ix })
      end
      
      def self.preamble_reader(key, default = nil)
        define_method(key) { self[key] || default }
      end
      
      preamble_reader :layout, nil
      preamble_reader :title, ''
      preamble_reader :subtitle, ''
      
      def find_page(url_cons)
        (url_cons == '') ? self : find_child_page(url_cons)
      end
      
      def find_child_page(url_cons)
        nxt, *cons = url_cons.split('/')
        @children[nxt] ||= load_child_page(nxt)
        @children[nxt] ? @children[nxt].find_page(cons.join('')) : nil
      end
      
    private
    
      # load a page at a path relative to current page and set the parent/URL
      def load_child_page(path_cons)
        load_child_from_relative_path(File.join(path_cons, 'index.page'), path_cons)
      end
      
      def load_child_from_relative_path(relative_path, url_component)
        child_path = File.join(File.dirname(path), relative_path)
        if File.readable?(child_path)
          child = site.load_page(child_path)
          child.parent = self
          child.url = url + url_component + '/'
          child
        else
          nil
        end
      end
      
    end
  end
end