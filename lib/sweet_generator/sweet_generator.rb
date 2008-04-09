require 'fileutils'

module TestSweet
  class SweetGenerator
    CURRENT_DIR = File.expand_path('.')
    
    APP_SKELETON = %w(
      config
      flows
      lib
      next_release
      pages
      regression
      script
      sites
      log
      tmp
    )
    
    FILE_MAPPING = {
      'rakefile.rb' => 'rakefile.rb',
      'application.rb' => File.join('lib','application.rb')
    }
    
    def initialize(name)
      @name = name
    end
  
    def generate_app
      @app_root = File.join(CURRENT_DIR,@name)
      
      if File.exists? @app_root
        puts "directory #{@name} exists: please pick another name"
      else
        generate_skeleton
        copy_files
        copy_scripts
      end
    end
    
    private
    
    def generate_skeleton
      FileUtils.mkdir(@app_root)
      
      APP_SKELETON.each do |dir|
        make_dir dir
      end
    end
    
    def copy_files
      FILE_MAPPING.each do |source_file,destination_file|
        copy_file source_file, destination_file
      end
    end
    
    def copy_scripts
      FileUtils.cp_r(File.join(File.dirname(__FILE__),'script','.'),File.join(@app_root,'script'))
      
      Dir.glob(File.join(@app_root,'script','**','**')) do |file|
        puts "creating file: #{File.expand_path(file)}"
        FileUtils.chmod(0755, file)
      end
    end
    
    def make_dir(dir)
      puts "creating directory: #{File.expand_path(File.join(@app_root,dir))}"
      FileUtils.mkdir_p(File.join(@app_root,dir))
    end
    
    def copy_file(source,destination)
      files_dir = File.join(File.dirname(__FILE__),'files')
      
      puts "creating file: #{File.join(@app_root,destination)}"
      FileUtils.cp(File.join(files_dir,source),File.join(@app_root,destination))
    end
  end
end