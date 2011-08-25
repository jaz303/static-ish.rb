module StaticIsh
  module Parts
    class Code < Base
      def highlighted_source
        pygmentize = `which pygmentize`.strip
        result = ''
        IO.popen("#{pygmentize} -l #{language} -f html #{highlight_options}", "r+") do |p|
          p.puts(source)
          p.close_write
          while !p.eof?
            result << p.gets
          end
        end
        result
      end
      
      def highlight_options
        opts = []
        opts << "linenos=table"
        opts << "linenostart=#{options[:start_line]}" if options[:start_line]
        opts << "hl_lines=#{options[:highlight_lines]}" if options[:highlight_lines]
        opts.map { |o| "-P \"#{o}\"" }.join(' ')
      end
      
      def caption
        options[:caption]
      end
      
      def language
        options[:language]
      end
      
      def defaults
        {:language => 'text'}
      end
    end
  end
end