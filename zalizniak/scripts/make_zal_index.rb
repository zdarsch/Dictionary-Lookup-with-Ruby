# encoding: Windows-1251
Encoding::default_external= "Windows-1251"

f=File.open("../zal_dict.txt")
g=File.open("_res.txt", "w")

rx=/^[-а-яё\47\140\d\/]+/

headwords=[]
a=f.readlines
a.each do |line|
headword= line[rx]
headword.gsub!(/[\47\140]/, "")
headword.gsub!("ё", "е")
headword=headword.split("/")[1] if headword=~/\//
headwords <<  headword
end

headwords.each_with_index do |wd, x|
g.puts "#{x}\t#{wd}"	
end