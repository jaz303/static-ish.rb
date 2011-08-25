require 'bluecloth'

module StaticIsh
  module Parts
    class Markdown < Base
      def render
        BlueCloth.new(source).to_html
      end
    end
  end
end