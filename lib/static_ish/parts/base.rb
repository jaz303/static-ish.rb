module StaticIsh
  module Parts
    class Base
      attr_reader :source, :options
      
      def self.defaults(options)
        define_method(:defaults) { options.dup }
      end
      
      def initialize(source, options)
        @source, @options = source, defaults.update(options)
      end
      
      def id
        @options[:id]
      end
      
      def defaults
        {}
      end
    end
  end
end