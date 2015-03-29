require 'stomp'
require 'active_model'
require 'logger'
require 'json'

# begin
  # Credentials setrequire 'rubygems'
# require 'stomp'

class JunctionListener

  include ActiveModel
  def initialize
    logger = Logger.new('logfile.log')
    logger.level = Logger::DEBUG  
    # Credentials set here as environment variables
    @user = 'd3user'
    @password = 'd3password'
    @host = "datafeeds.nationalrail.co.uk"
    @port = 61613
    @uuid = 'D36f743bd6-a870-4f9c-9424-aa1b901642b3'
    @destination = "/queue/#{@uuid}"
  end


  def subscribe
    begin
      puts "Connecting to datafeeds as #{@user} using stomp protocol stomp://#{@host}:#{@port}\n"
      @connection = Stomp::Connection.open @user, @password, @host, @port, true
      @connection.subscribe (@destination)
      newfile = File.new('logfile.gz', 'w')
      while true
        @msg = @connection.receive
        # puts @msg
        # puts @msg.public_methods
        # puts @msg.class
        # puts @msg.body.class
        # puts @msg.body.methods
        newfile.puts(@msg)
        puts @msg.body
        # puts Zlib::Inflate.inflate(@msg.body)
        # puts inflate(@msg.body)
        # logfile.puts(@msg)
        # newfile.close
        # logger.info(@msg)
      end
      @connection.disconnect
      newfile.close()
    rescue
    end

  end
  # Example destination add yours here
  # @destination = "/queue/TD_MC_EM_SIG_AREA"

  def inflate(string)
    zstream = Zlib::Inflate.new
    buf = zstream.inflate(string)
    zstream.finish
    zstream.close
    buf
  end
end


listener = JunctionListener.new()

listener.subscribe
