require 'net/http'
require 'json'
require 'readline'
require 'domainr/operations'
require 'domainr/colorize'

module Domainr
  class Console
    def initialize
      loop {
        buf = ::Readline::readline('domai.nr> ', true)
        enter(buf)        
      }

    end

    def enter(command)
      if command == 'exit'
        exit
      end
      command =~ /(.*) (.*)/
      cmd = $1
      args = $2

      case cmd
        when 'search'
          Operations.search(args)
        when 'info'
          Operations.info(args)
        
        else
          puts "Command not found"
      end
      

    end

    
  end
end

