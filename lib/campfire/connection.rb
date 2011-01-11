require 'net/http'

module Campfire
  class Connection
    attr_reader :subdomain, :token

    def initialize(options)
      @subdomain = options[:subdomain]
      @token     = options[:token]
    end

    def get(path)
      parse_json request(:get, path)
    end

  private

    # TODO: handle invalid auth
    # TODO: handle ssl
    def request(method, path)
      Net::HTTP.start(host_with_subdomain, :use_ssl => true) do |http|
        request = Net::HTTP.const_get(method.to_s.capitalize).new(path)
        request.basic_auth @token, "X"
        http.request(request).body
      end
    end

    def host_with_subdomain
      @host_with_subdomain ||= "#{@subdomain}.campfirenow.com"
    end

    # TODO: handle parsing errors
    def parse_json(response)
      parser.parse(response)
    end

    def parser
      @parser ||= Yajl::Parser.new
    end
  end
end
