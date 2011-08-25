module StaticIsh
  module Parts
    class Base
      def self.type;        @type;              end
      def self.type=(t);    @type = t.to_sym;   end
      
      attr_accessor :page
      attr_reader :source, :options
      
      def self.defaults(options)
        define_method(:defaults) { options.dup }
      end
      
      def initialize(source, options = {})
        options = options.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
        @source, @options = source, defaults.update(options)
      end
      
      def id
        @options[:id]
      end
      
      def type
        self.class.type
      end
      
      def defaults
        {}
      end
    end
  end
end