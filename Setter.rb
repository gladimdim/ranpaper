class Setter
	attr_reader :input_dir, :config_file
	def initialize 
		@config_file = ENV['HOME'] + "/.ranpaper"
		if !File::file?(config_file) then
			puts "Please create file in your home directory \"~/.ranpaper\" and add full path to directory with wallpapers. Then rerun program."
			Kernel.exit
		end
		file = File.open(config_file)
		@input_dir = File.read(file).to_s.chomp! 
		if !File::directory?(input_dir) then
			puts "Specified directory \""<< input_dir << "\" could not be found"
			Kernel.exit()
		end
	end

	def set_feh(image)
		feh_command = "feh --bg-scale " + image
		system(feh_command)
	end

	def set_fbsetbg(image)
		fbsetbg_command = "fbsetbg -f " + image
		system(fbsetbg_command)
	end

	def success_set(app, wallpaper)
		puts "Wallpaper #{wallpaper} was set using #{app}"
	end
end
