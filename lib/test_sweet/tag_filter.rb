module TestSweet
  class TagFilter
    class << self
      def filter(pattern,tags)
        Dir.glob(pattern).select do |file_name|
          contains_tags?(file_name,tags)
        end
      end
      
      private
      
      def contains_tags?(file_name,tags)
        file_string = File.open(file_name).read
        tags.all? { |tag| file_string =~ /#\s?tags:(\s?\w+,)* #{tag},?(\s?\w+,)*/ }
      end
    end
  end
end