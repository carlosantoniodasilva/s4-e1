module Campfire
  class Connection
    include HTTParty
    headers 'Content-Type' => 'application/json'

    attr_reader :subdomain, :token

    # TODO: handle invalid auth
    # TODO: handle ssl
     def initialize(options)
      @subdomain = options[:subdomain]
      @token     = options[:token]

      self.class.base_uri(host_with_subdomain)
      self.class.basic_auth(@token, 'X')
    end

    # TODO: handle parsing errors
    def get(path)
      self.class.get(path)
    end

    def post(path)
      self.class.post(path)
    end

    private

    def host_with_subdomain
      @host_with_subdomain ||= "https://#{@subdomain}.campfirenow.com"
    end
  end
end
