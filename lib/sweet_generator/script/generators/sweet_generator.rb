require 'fileutils'

module TestSweet
  class SweetGenerator
    def add_file(file_name, contents)
      alert_added file_name
      File.open(file_name,'w') do |out|
        out << contents
      end
    end
    
    def make_dir(dir_name)
      alert_added dir_name
      FileUtils.mkdir(dir_name)
    end
    
    def alert_added(file_name)
      puts "creating file: #{File.expand_path(file_name)}"
    end
  end
end