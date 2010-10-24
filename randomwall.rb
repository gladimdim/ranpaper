#!/usr/bin/ruby

class Wallpaper
	def initialize(wallpaper_dir)
		@wallpaper_dir = wallpaper_dir
	end
	attr_reader :wallpapper_dir
	attr_reader :list_of_images

	#First we load all files from input directory
	def get_list_of_files
		@list_of_files = Array.new
		@list_of_files = Dir.entries(@wallpaper_dir) if File::directory?(@wallpaper_dir)
	end

	#Only images with specified extensions "bmp", "jpg", "gif" are left
	def get_list_of_images
		@list_of_images = Array.new
		if @get_list_of_files != nil then 
			puts "not nil"
			self.get_list_of_files().each { |file| @list_of_images << file if file.to_s.include?("gif") or file.to_s.include?("jpg") or file.to_s.include?("bmp")	}
		return @list_of_images
		else return nil
		end
	end
	
	def select_random_image

		image = self.get_list_of_images[0 + rand(@list_of_images.size())]
		return image
	end

end
@input_dir = "/home/gladimdim/Documents/wallpapers/"
wallpap = Wallpaper.new(@input_dir)

random_image = @input_dir << wallpap.select_random_image
@feh_command = "feh --bg-scale " + random_image
value = system(@feh_command)

if $?.exitstatus == 0 then
	puts "Wallpaper will be set: " + random_image if $?.exitstatus == 0
	else puts "Error setting wallpaper image: " + random_image
	end
 
