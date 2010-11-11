class Wallpaper
	attr_reader :random_image
	def initialize(wallpaper_dir)
		if File::directory?(wallpaper_dir) then
			@wallpaper_dir = wallpaper_dir
			@list_of_images = Array.new
		end
	end
	#First we load all files from input directory
	def get_list_of_files
		@list_of_files = Dir.entries(@wallpaper_dir) 
	end
	#Only images with specified extensions "bmp", "jpg", "gif" are left
	def get_list_of_images
		if @list_of_files != nil then 
			@list_of_files.each { |file| @list_of_images << file if file.to_s.include?(".gif") or file.to_s.include?(".jpg") or file.to_s.include?(".bmp")	}
		else
			@list_of_images = nil
		end
	end
	def select_random_image
		if @list_of_images != nil and @list_of_images.count != 0 then
			@random_image = @wallpaper_dir + @list_of_images[0 + rand(@list_of_images.size())]
		else 
			@random_image = nil
		end
	end
end
