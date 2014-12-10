#!/usr/bin/env ruby

require 'socket'
require 'sysinfo'

#myIP=Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][1]
#p myIP

# ip = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
#    puts ip

#METHOD 1
#    ip = IPSocket.getaddress(Socket.gethostname)
#    puts ip 

#METHOD 2
    host = Socket.gethostname
    puts host

#p sysinfo.cpu

def mac_address
  platform = RUBY_PLATFORM.downcase
  output = `#{(platform =~ /win32/) ? 'ipconfig /all' : 'ifconfig'}`
  case platform
    when /darwin/
      $1 if output =~ /en1.*?(([A-F0-9]{2}:){5}[A-F0-9]{2})/im
    when /win32/
      $1 if output =~ /Physical Address.*?(([A-F0-9]{2}-){5}[A-F0-9]{2})/im
    # Cases for other platforms...
    else nil
  end
end

p mac_address
