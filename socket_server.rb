require 'socket'

class ClientQuitError < RuntimeError; end

port = ARGV.shift || 0 # default is to use the next available port
host = ARGV.shift # default is to bind everything

server = host ? TCPServer.open(host, port) : TCPServer.open(port)

port = server.addr[1]
addrs = server.addr[2..-1].uniq

puts "*** listening on #{addrs.collect{|a|"#{a}:#{port}"}.join(' ')}"

loop do
  socket = server.accept

  Thread.start do # one thread per client
    s = socket

    port = s.peeraddr[1]
    name = s.peeraddr[2]
    addr = s.peeraddr[3]

	sock_domain, remote_port, remote_hostname, remote_ip = s.peeraddr

    open('log.txt', "a") do |file|
    puts "*** recieving from #{name}:#{port}"
    file.puts "*** recieving from #{name}:#{port}"
    end

    begin
      while line = s.gets # read a line at a time
        raise ClientQuitError if line =~ /^die\r?$/
        #puts "#{remote_ip} [#{Time.now}]: #{line}"
        puts "#{addr} [#{Time.now}]: #{line}"
    open('log.txt', "a") do |file|
        file.puts "#{addr} [#{Time.now}]: #{line}"
    end
	s.puts "Received\r"
	#numbers = line.to_s.scan /[-+]?\d*\.?\d+/
	numbers = line.scan /[-+]?\d*\.?\d+/
        letters = line.scan /[a-zA-Z]/
	s.print numbers
	s.puts " "
	s.print letters
	if #{line} == "quit"
		exit 1
		s.close
	end
    end

    rescue ClientQuitError
      puts "*** #{name}:#{port} disconnected"

    ensure
      s.close # close socket on error
    end

    puts "*** done with #{name}:#{port}"
  end

end

