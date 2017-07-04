module Rubrowser
  module Parser
    class Directory
      attr_reader :directory

      def initialize(directory)
        @directory = directory
        files = Dir.glob(::File.join(directory, '**', '*.{rb,rake}'))
        @parsers = files.map { |f| File.new(f) }
      end

      def parse
        parsers.each(&:parse)
      end

      def definitions
        parsers.map(&:definitions).map(&:to_a).reduce([], :+)
      end

      def relations
        parsers.map(&:relations).map(&:to_a).reduce([], :+)
      end

      private

      attr_reader :parsers
    end
  end
end
