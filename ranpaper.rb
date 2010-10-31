#!/usr/bin/env ruby

class Wallpaper
	attr_reader :result
	attr_reader :random_image
	@@random_image = nil 
	@@wallpaper_dir = nil
	@@result = nil
	@@list_of_images = Array.new 
	def random_image
		return @@random_image
	end
	def initialize(wallpaper_dir)
		if File::directory?(wallpaper_dir) then
			@@wallpaper_dir = wallpaper_dir
			self.get_list_of_images()
			self.select_random_image()
		else
			result = nil
		end
	
	end

	#First we load all files from input directory
	def get_list_of_files
		@@list_of_files = Dir.entries(@@wallpaper_dir) 
		return @@list_of_files
	end

	#Only images with specified extensions "bmp", "jpg", "gif" are left
	def get_list_of_images
		if self.get_list_of_files() != nil then 
			self.get_list_of_files().each { |file| @@list_of_images << file if file.to_s.include?("gif") or file.to_s.include?("jpg") or file.to_s.include?("bmp")	}
		return @@list_of_images
		else return nil
		end
	end
	
	def select_random_image
		if @@list_of_images != nil then
			@@random_image = @@list_of_images[0 + rand(@@list_of_images.size())]
			return @@random_image
		else 
			return nil
		end
	end
end

def success(app, wallpaper)
	puts "Wallpaper \"" + wallpaper + "\" was set using " + app
end
if ARGV.count != 0 then
	ARGV.each do |arg|
		if arg == "--help" then

			puts "Usage:"
			puts "--test - testing which background setters can be used."
			puts "--help - print this help."
			puts
			puts "Random wallpaper changer."
			puts "Specify in file ~/.ranpaper a single string with path to directory with wallpapers. Each time ranpaper is run it will randomly select wallpaper from specified directory.\n" +
				"Only jpg, bmp and gif files are supported. You need to have \"feh\" or \"fbsetbg\" packages installed. " + 
				"Application will first try to use \"feh\" and then \"fbsetbg\"."

			puts "\nAuthor: Dmitry Gladkiy <gladimdim@gmail.com>."
			puts "\nVisit http://github.com/gladimdim/ranpaper for new versions.\n"

			Kernel.exit
		end
		if arg == "--test" then
			value = system("feh -h > /dev/null")
			if $?.exitstatus == 0 then
				puts "feh package is installed and can be used by random wallpaper application."
			else
				puts "feh package is not installed."
			end
			value = system "fbsetbg -h > /dev/null"

			if $?.exitstatus == 0 then
				puts "fbsetbg package is installed and can be used by random wallpaper application."
			else
				puts "feh package is not installed."
			end
			Kernel.exit
		end

	end
	puts ("Unknow argument. Try --help to get list of available arguments.")
	Kernel.exit
end


#Setting path to ~/.ranpaper file which contains single string to wallpapers directory
config_file = ENV['HOME'] + "/.ranpaper"

if !File::file?(config_file) then
	puts "Please create file in your home directory \"~/.ranpaper\" and add full path to directory with wallpapers. Then rerun program."
	Kernel.exit
end

file = File.open(config_file)

input_dir = File.read(file).to_s.chomp! 

if !File::directory?(input_dir) then
	puts "Specified directory \""<< input_dir << "\" could not be found"
	Kernel.exit()
end

wallpap = Wallpaper.new(input_dir)

if wallpap.random_image != nil then
	random_image = input_dir << wallpap.random_image
	else 
		puts ("No images where found in " + input_dir + ". Terminating.")
		Kernel.exit
end

feh_command = "feh --bg-scale " + random_image
fbsetbg_command = "fbsetbg -f " + random_image

value = system(feh_command)

if $?.exitstatus == 0 then
	success("feh", random_image)
	else 
		value = system(fbsetbg_command)
		if $?.exitstatus == 0 then
			success("fbsetbg", random_image)
		else puts "Error seting wallpaper image: " + random_image
	end
	
end
 
