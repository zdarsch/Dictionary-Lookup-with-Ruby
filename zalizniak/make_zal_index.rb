Encoding::default_external="Windows-1251"

f=File.open("zal_dict.txt")
h=File.open("zal_index.txt", "w")

offsets=[0] # line offsets
while line= f.gets do
line.rstrip!
next if line=~/^$/# skip empty line
offsets<< f.tell unless f.eof
end#while
#
headwords=File.readlines("headwords.txt")

a=offsets.zip(headwords)
a.map!{|ar| ar.join("\t")}
h.puts a



