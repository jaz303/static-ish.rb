module StaticIsh
  module Pages
    class Base
      attr_accessor :parent
      attr_reader :path
      attr_reader :parts
      
      def [](k);      @preamble[k.to_sym];          end
      def []=(k,v);   @preamble[k.to_sym] = v;      end
      
      def initialize(path, preamble = {}, parts = [])
        @path, @preamble, @parts = path, preamble, parts
      end
      
      def self.preamble_reader(key, default = nil)
        define_method(key) { self[key] || default }
      end
      
      preamble_reader :title
      preamble_reader :subtitle
    end
  end
end