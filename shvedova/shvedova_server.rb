# encoding:  Windows-1251
Encoding::default_external= "Windows-1251"

#ruby274 on Windows 10
require 'webrick'
require 'cgi'
include WEBrick
#
s1="\300-\337\250\270"
s2="\340-\377\345\345"  
#
dict=File.readlines("shv_dict.txt")
index=File.readlines("shv_index.txt") 

server = WEBrick::HTTPServer.new(:Port => 8080)
server.mount_proc("/shvedova") do |request, response|
if expression = request.query['word'] then
# convert:
expression = CGI.unescape(expression).strip
expression.encode!("Windows-1251", "UTF-8")
#
expression.strip!
expression.tr!(s1, s2)
expression=expression.gsub(/[\'\"\`]/, "")
#
rx=/\t#{expression}/
a=index.grep(rx)

a.map! do |line|
x = $1.to_i if  line =~ /^(\d+)\t/
line=dict[x]    
end#map!

if a.empty? then
str="Not Found"
else
a.uniq! # prevents repetitions	    
str=a.join("<br><br>").gsub("\\n", "<br>")
end#if2
html="<style>body{font-style: normal;font-weight: normal;font-size: 30px;font-family: \"Times New Roman\";background-color:#f8f8f8;color:#000050;}</style><body>#{str}\n</body>"
response.status = 200
response.content_type = 'text/html; charset=Windows-1251'
response.body = html
end#if1
end#mount_proc
server.start


