#!/usr/bin/env ruby
require "#{File.dirname(__FILE__)}/Wallpaper.rb"
require "#{File.dirname(__FILE__)}/Setter.rb"

if ARGV.count != 0 then
	ARGV.each do |arg|
		if arg == "--help" then

			puts "Usage:"
			puts "--test - testing which background setters can be used."
			puts "--help - print this help."
			puts
			puts "Random wallpaper changer."
			puts "Specify in file ~/.ranpaper a single string with path to directory with wallpapers. Each time ranpaper is run it will randomly select wallpaper from specified directory.\n" +
				"Only jpg, bmp and gif files are supported. You need to have \"feh\", \"wmsetbg\" or \"fbsetbg\" packages installed. " + 
				"Application will try to set wallpaper with all of them."

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

			value = system "wmsetbg --help > /dev/null"
			if $?.exitstatus == 0 then
				puts "wmsetbg package is installed and can be used by random wallpaper application".
			else
				puts "wmsetbg package is not installed."
			end
			Kernel.exit
		end

	end
	puts ("Unknow argument. Try --help to get list of available arguments.")
	Kernel.exit
end


#Setting path to ~/.ranpaper file which contains single string to wallpapers directory
setter_ranpaper = Setter.new
wallpap = Wallpaper.new(setter_ranpaper.input_dir)
if wallpap.random_image != nil then
	image_to_set = wallpap.random_image
	else 
		puts ("No images were found in #{setter_ranpaper.input_dir}. Terminating.")
		Kernel.exit
end

value = setter_ranpaper.set(image_to_set) 

