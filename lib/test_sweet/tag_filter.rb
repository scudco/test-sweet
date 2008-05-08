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
        tags.all? { |tag| file_string =~ /TestSweet\.tag( :\w+,)* :#{tag}( :\w+,)*/ }
      end
    end
  end
end