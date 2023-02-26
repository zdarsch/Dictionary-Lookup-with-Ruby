# encoding:  Windows-1251
Encoding::default_external= "Windows-1251"

#ruby274 on Windows 10
require 'cgi'
require 'webrick'
include WEBrick

class Node
attr_accessor  :edges 
def initialize	
@edges=[]
end
end#Node

# Load  the lemmer
f=File.open("lemmer.fsa", "rb")
@h = Hash.new { |hash, key| hash[key] = Node.new }
x, edge = 0, []
while s=f.read(4) do
edge=[ s[0].ord, (s[1].ord>>2) + (s[2].ord<<6) + (s[3].ord<<14), s[1].ord&3 ] 
@h[x].edges << edge
(x+=1; @h[x]) if s[1].ord&2==2  #last edge of node
end#while


@candidate=[]
@codes=[]

def dfs(n,  depth)
i=depth	
node=@h[n]
node.edges.each do |edge|
        @candidate[i]=edge[0].chr
        if edge[2]&1==1 then
	@candidate.slice!(i+1 .. -1)
        @codes<<@candidate.join
	end#if
         dfs(edge[1],  i+1)
end#each
end#dfs

def include?(word)
node=@h[0]
word.each_byte.with_index do |byte, x| 
edge=node.edges.assoc(byte)
return false unless edge
node=@h[edge[1]]
if x==word.length-1 then
return edge[1]
end#if
end#each_byte
end #include?
#
s1="\300-\337\250\270"
s2="\340-\377\345\345"    
#
dict=File.readlines("shvedova2_dict_vers_8.txt")   
index=File.readlines("shvedova2_index.txt")

server = WEBrick::HTTPServer.new(:Port => 8080)
server.mount_proc("/lemmer") do |request, response|
if expression = request.query['word'] then
@codes.clear ##
# convert:
expression=CGI.unescape(expression).strip
expression.encode!("Windows-1251", "UTF-8")
#
expression.strip!
expression.tr!(s1, s2)
expression.gsub!(/[\'\"\`]/, "")
#
x= include?(expression+"+")
 dfs(x,  0) 

a=[]
@codes.each do |code|
code.force_encoding("Windows-1251")
form=expression.dup ##
code,  prefix = code.split("/")
n=code[/\d+/].to_i
suffix=code[/[\340-\377]+/].to_s
if prefix then
m=prefix[/\d+/].to_i
prefix=prefix[/[\340-\377]+/].to_s
form[0, m]= ""       #delete from start
form=prefix+form
end
form[-n, n]=""         #delete from end
a<< form+suffix	
end#each

a.map! do |expression|
rx=/\t#{expression}$/ # whole match search
index.grep(rx)
end
a.flatten!
a.map! do |line|
x = $1.to_i if  line =~ /^(\d+)\t/
line = dict[x]  
end#map!

if a.empty? then
str="Not Found"
else
str=a.join("<br><br>").gsub("\\n", "<br>")
end#if
html="<style>body{font-style:normal;font-weight:normal;font-size:30px;font-family:\"Times New Roman\";background-color:#f8f8f8;color:#000050;}</style><body >#{str}</body>"
response.status = 200
response.content_type = 'text/html; charset=windows-1251'
response.body = html
end#if query
end#mount_proc

server.start


