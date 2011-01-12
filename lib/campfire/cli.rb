require "optparse"

module Campfire
  class Cli
    attr_reader :options

    def initialize(argv)
      @argv    = argv
      @options = { :command => :rooms }
      parse_options
      validate_options
    end

    def run
      manager.send(@options[:command])
    end

    private

    def parse_options
      options_parser.parse!(@argv)
    end

    def options_parser
      @options_parser ||= OptionParser.new do |opt|
        opt.banner = "Campfire Command Line Tool"

        opt.on "-s", "--subdomain SUBDOMAIN", "Your subdomain on Campfire" do |value|
          @options[:subdomain] = value
        end
        opt.on "-t", "--token TOKEN", "Your access token for Campfire" do |value|
          @options[:token] = value
        end

        opt.on "--rooms", "List all rooms" do |value|
          @options[:command] = :rooms
        end
      end
    end

    def validate_options
      [:subdomain, :token].each do |required_option|
        next if options[required_option]
        raise OptionParser::MissingArgument, "#{required_option.capitalize} is missing"
      end
    end

    def manager
      @manager ||= Manager.new(
        :subdomain => @options[:subdomain],
        :token     => @options[:token]
      )
    end
  end
end
