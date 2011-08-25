require 'redcloth'

module StaticIsh
  module Parts
    class Textile < Base
      def render
        RedCloth.new(source).to_html
      end
    end
  end
end