module StaticIsh
  module Pages
    class Base
      attr_reader :site         # site to which this page belongs
      attr_reader :path         # absolute FS path to this page
      attr_reader :parts        # array of page parts
      attr_accessor :parent     # parent page
      
      def [](k);      @preamble[k.to_sym];          end
      def []=(k,v);   @preamble[k.to_sym] = v;      end
      
      def initialize(site, path, preamble = {}, parts = [])
        preamble = preamble.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
        @site, @path, @preamble, @parts = site, path, preamble, parts
        
        relative_path = path[@site.public_root.length..-1]
        p relative_path
      end
      
      def url
        if parent.nil?
          url_component
        else
          File.join(parent.url, url_component)
        end
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
      
      preamble_reader :layout
      preamble_reader :title
      preamble_reader :subtitle
      
      def find_page(path)
        self
      end
    end
  end
end