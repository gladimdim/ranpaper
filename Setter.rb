class Setter
	attr_reader :input_dir, :config_file, :list_of_setters
	@list_of_setters = Array.new
	@list_of_setters = ["feh", "fbsetbg", "wmsetbg"]
	def initialize 
		@config_file = ENV['HOME'] + "/.ranpaper"
		if !File::file?(config_file) then
			puts "Please create file in your home directory \"~/.ranpaper\" and add full path (with trailing ""/"") to directory with wallpapers. Then rerun program."
			Kernel.exit
		end
		file = File.open(config_file)
		@input_dir = file.gets.chomp! 
		if !File::directory?(input_dir) then
			puts "Specified directory \""<< input_dir << "\" could not be found"
			Kernel.exit()
		end
		@list_of_setters = ["feh", "fbsetbg", "wmsetbg"]
	end

	def feh(wallpaper)
		feh_command = "feh --bg-center " + wallpaper
		system(feh_command)
	end

	def fbsetbg(wallpaper)
		fbsetbg_command = "fbsetbg -f " + wallpaper
		system(fbsetbg_command)
	end

	def wmsetbg(wallpaper)
		wmsetbg_command = "wmsetbg --center " + wallpaper
		system(wmsetbg_command)
	end

	def success_set(app, wallpaper)
		puts "Wallpaper #{wallpaper} was set using #{app}"
	end
	
	def set(image_to_set)
		@list_of_setters.each do |setter|
			value = self.send(setter, image_to_set)
			if $?.exitstatus == 0 then
				success_set(setter, image_to_set)
				Kernel.exit
			else
				puts "Error settings image wallpaper #{image_to_set} using #{setter}."	
			end

		end
	end
	private :success_set
end
