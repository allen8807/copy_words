require 'fileutils'
dirname = gets
dirname.strip!
FileUtils.mkdir_p(dirname)
outfile = File.open(dirname + "/__" + dirname + "_failed_words.txt", "a+")
File.open("list.txt", "r") do |file|
  file.each_line { |line|
    line.strip!
    name = line + ".mp3"
    fullName = "voice/" + line[0, 1] + "/" + name
    puts fullName
    if (FileTest.exist?(fullName))
      FileUtils.cp_r(fullName, dirname + "/" + name)
      puts name + " was copied!"
    else
      puts name + " is not existed!"
      outfile.puts line
    end
  }
  file.close
  outfile.close
end

