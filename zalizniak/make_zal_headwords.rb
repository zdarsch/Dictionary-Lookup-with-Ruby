#Encoding: Windows-1251
Encoding::default_external= "Windows-1251"


f=File.open("zal_dict.txt")
g=File.open("headwords.txt", "w")



rx=/^[-\340-\377\270\47\140\d\/]+/ 

while line=f.gets do
line.rstrip!
next if line=~/^$/# skip empty line
next if line=~/^[\300-\337\250]/ #skip capitalized line
if line=~rx then
headword=$&
headword.gsub!(/[\47\140]/, "") # remove stress marks(acute, grave)
headword.gsub!("\270", "\345") # yo to ye
# remove numbers preceding headwords:
headword=headword.split("/")[1] if headword=~/\//
g.puts headword
end#if
end#while



