Encoding.default_external="Windows-1251"

require 'webrick'
require 'cgi'
include WEBrick

  server = WEBrick::HTTPServer.new(:Port => 8080)
  server.mount_proc("/zal") do |request, response|
    if expression = request.query['word'] then
    expression = CGI.unescape(expression).strip
    expression.encode!("Windows-1251", "UTF-8")
    rx=/\t#{expression}/
    a=File.readlines("zal_index.txt").grep(rx)
    f=File.open("zal_dict.txt")
    a.map! do |line|
    f.pos = $1.to_i if  line =~ /^(\d+)\t/
    line = f.gets   
    end#map!
    if a.empty? then
    str="Not Found"
    else
    str=a.join("<br>").gsub("\\n", "<br>")
    end#if
    html="<style>body{font-style: normal;font-weight: normal;font-size: 30px;font-family: \"Times New Roman\";background-color:#f8f8f8;color:#000050;}</style>\n<body>#{str}\n</body>"
    response.status = 200
    response.content_type = 'text/html; charset=Windows-1251'
    response.body = html
    end#if query
  end#mount_proc
  server.start


