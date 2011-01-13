module Campfire
  class Connection
    include HTTParty

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

    private

    def host_with_subdomain
      @host_with_subdomain ||= "#{@subdomain}.campfirenow.com"
    end
  end
end
