# 思路：
# => A.遍历目录对象
# => B.获取目录下的文件名称File对象
# => C.截取新的文件命名
# => D.检查重名问题
# => E.重命名
require 'find'
require 'pathname'
require 'fileutils'

puts "#####################    begin   #######################\r\n"
puts "########################################################\r\n"
DIR_PHOTOS = "./Lv5L1"
i = 0 #定义变量记录所有的符合规定格式的文件数量
j = 0 #记录被处理过的文件数量

Find.find(DIR_PHOTOS) do |filename|
  path = Pathname.new(filename)
  extname = path.extname      # 文件后缀名
  #puts filename.to_str
  #puts path.basename
  #puts extname

  begin
    i = i + 1
    primary_name = path.basename        # 文件名
    name = filename.to_str
    puts "------------- #{i} old name :  #{primary_name}"
    if name.include?("(")
      puts "not deal " + name
    else
      m = name.split(/&pq=/)[-1]
      new_name=m.split(/&sc/)[0]
      if new_name.length > 30
        m = name.split(/com_images_search_q=/)[-1]
        new_name=m.split(/&/)[0]
      end
      new_name = DIR_PHOTOS+"/"+new_name+extname
      if (FileTest.exist?(new_name))
        puts new_name +"is already existed"
      else
        j = j + 1
        File.rename(filename,new_name)
        puts "rename :  #{new_name} \n"
      end
    end
  rescue Exception => e
    puts e
  end
end
puts "all #{i}"
puts "deal #{j} "