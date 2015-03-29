require "stomp"

class NrPollerPoller

  # Initialize the poller

  def initialize

    @hostname = 'datafeeds.nationalrail.co.uk'
    @username = 'd3user'
    @password = 'd3password'
    puts "Stomp consumer for Network Rail Open Data Distribution Service"
    @uuid = 'D36f743bd6-a870-4f9c-9424-aa1b901642b3'

  end


  # Connect to the service and process messages

  def run

    client_headers = { "accept-version" => "1.1", "heart-beat" => "5000,10000", "client-id" => Socket.gethostname, "host" => @hostname }
    client_hash = { :hosts => [ { :login => @username, :passcode => @password, :host => @hostname, :port => 61613, :ssl => false } ], :connect_headers => client_headers }
    puts client_hash
    client = Stomp::Client.new(client_hash)

    # Check we have connected successfully
    raise "Connection failed" unless client.open?
    raise "Connect error: #{client.connection_frame().body}" if client.connection_frame().command == Stomp::CMD_ERROR
    raise "Unexpected protocol level #{client.protocol}" unless client.protocol == Stomp::SPL_11

    puts "Connected to #{client.connection_frame().headers['server']} server with STOMP #{client.connection_frame().headers['version']}"
    puts Socket.gethostname
    queue = "/queue/#{@uuid}"
    # Subscribe to the RTPPM topic and process messages

    client.subscribe(queue, { 'id' => @uuid, 'ack' => 'client' }) do |msg|

      newfile = File.open("testfile.txt","w"){|file| file.write(msg.body)}
      puts msg.body
      client.acknowledge(msg, msg.headers)

    end

    client.join


    # We will probably never end up here

    client.close
    puts "Client close complete"

  end

end

e = NrPollerPoller.new
puts e
e.run