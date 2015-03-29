USERNAME = 'd3user'
PASSWORD = 'd3password'
HOST = "datafeeds.nationalrail.co.uk"
PORT = 61613
CLIENTKEY = 'D36f743bd6-a870-4f9c-9424-aa1b901642b3'


newfile=File.open('logfile.txt')

def inflate(string)
	zstream = Zlib::Inflate.new
	buf = zstream.inflate(string)
	zstream.finish
	zstream.close
	buf
end

puts inflate(newfile.to_s)