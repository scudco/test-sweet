require 'fileutils'

module TestSweet
  class SweetDestroyer
    def remove_file(file_name)
      alert_removal(file_name)
      FileUtils.rm(file_name)
    end
    
    def remove_dir(dir_name)
      alert_removal(dir_name)
      FileUtils.rm_rf(dir_name)
    end
    
    def alert_removal(file_name)
      puts "removing: #{File.expand_path(file_name)}"
    end
  end
end