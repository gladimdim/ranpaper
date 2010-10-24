#!/usr/bin/ruby

class Wallpaper
	attr_reader :result
	@wallpaper = ""
	@result = nil
	def initialize(wallpaper_dir)
		if File::directory?(wallpaper_dir) then
			@wallpaper_dir = wallpaper_dir
			result = true
		else
			result = nil
		end
		
	end

	#First we load all files from input directory
	def get_list_of_files
		@list_of_files = Dir.entries(@wallpaper_dir) 
		return @list_of_files
	end

	#Only images with specified extensions "bmp", "jpg", "gif" are left
	def get_list_of_images
		@list_of_images = Array.new
		if self.get_list_of_files() != nil then 
			self.get_list_of_files().each { |file| @list_of_images << file if file.to_s.include?("gif") or file.to_s.include?("jpg") or file.to_s.include?("bmp")	}
		return @list_of_images
		else return nil
		end
	end
	
	def select_random_image
		if self.get_list_of_images != nil then
			image = self.get_list_of_images[0 + rand(self.get_list_of_images().size())]
		return image
		else 
			return nil
		end
	end
end

@input_dir = "/home/gladimdim/Documents/wallpapers/"

if !File::directory?(@input_dir) then
	puts "Specified directory \""<< @input_dir << "\" could not be found"
	Kernel.exit()
end

wallpap = Wallpaper.new(@input_dir)

random_image = @input_dir << wallpap.select_random_image()
@feh_command = "feh --bg-scale " + random_image
value = system(@feh_command)

if $?.exitstatus == 0 then
	puts "Wallpaper was set: " + random_image if $?.exitstatus == 0
	else puts "Error seting wallpaper image: " + random_image
end
 
