module Domainr
  class Operations

    def self.info(domain)
      response = JSON.parse(Net::HTTP.get(URI("https://api.domainr.com/v1/info?client_id=ruby_pablo_merino&q=#{domain}")))
      puts "Domain: #{response['domain']}"

      response['registrars'].each do |result|
        puts "Registrar: #{result['name']} (#{result['registrar']})"
      end

      puts "TLD: #{response['tld']['domain']}"
      puts "IANA URL: #{response['tld']['iana_url']}"
      puts "Wikipedia URL: #{response['tld']['wikipedia_url']}"
    end


    def self.search(query)
      @responses_array = Array.new
      response = JSON.parse(Net::HTTP.get(URI("https://api.domainr.com/v1/search?client_id=ruby_pablo_merino&q=#{query}")))
      print_domains response
      catch (:done) do
        loop {
          buf = ::Readline::readline('Select domain > ', true)
          if buf == "list"
            print_domains response
          elsif buf == 'back'
            throw :done
          elsif buf.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
            puts "Write here the number of the domain you want!"
          else
            if @responses_array[buf.to_i-1]['availability'].to_sym == :unavailable
              puts "That domain is not available"
            elsif @responses_array[buf.to_i-1]['availability'].to_sym == :tld
              puts "That domain is a TLD"
            else
              begin
                subshell @responses_array[buf.to_i-1]
              rescue
                puts "Not a valid selection"
              end
            end
          end
        }
      end
    end

    def self.subshell(response)
      catch (:done) do
        loop {
          buf = ::Readline::readline("Selected #{response['domain']} > ", true)

          case buf
            when 'register'
              puts 'Opening register window...'
              system "open #{response['register_url']}"

            when 'back'
              throw :done
          end
        }
      end
    end

    def self.print_domains(response)

      puts "Query: #{response['query']}"
      response['results'].each_with_index do |result, index|
        puts "#{index+1}:"
        puts "Domain: #{result['domain']}"
        case result['availability'].to_sym
          when :available
            puts "Availability: #{result['availability'].green}"
          when :taken
            puts "Availability: #{result['availability'].yellow}"
          when :unavailable
            puts "Availability: #{result['availability'].red}"
          when :tld
            puts "Availability: #{result['availability'].red}"
        end
        @responses_array.push result
      end

    end
  end
end
