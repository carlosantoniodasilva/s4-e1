require "optparse"

module Campfire
  class Cli
    attr_reader :options

    def initialize(argv)
      @argv    = argv
      @options = {}
      parse_options
      validate_options if options?
    end

    def run
      return options_parser.inspect unless options?

      obj = manager.send(*Array(@options[:command]))
      obj = obj.send(*@options[:subcommand]) if @options[:subcommand]
      obj
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

        opt.separator ""

        opt.on "--rooms", "List all rooms" do
          @options[:command] = :rooms
        end
        opt.on "--presence", "List all rooms that I am currently in" do
          @options[:command] = :presence
        end
        opt.on "--search TERM", "Search the given term" do |value|
          @options[:command] = [:search, value]
        end

        opt.on "--room ROOM_ID", Integer, "Select room id to run a sub command" do |value|
          @options[:command] = [:room, value]
        end
        opt.on "--speak MESSAGE", "Send a message to the given room (see --room)" do |value|
          @options[:subcommand] = [:speak, value]
        end
        opt.on "--paste CONTENT", "Paste the given content to the given room (see --room)" do |value|
          @options[:subcommand] = [:paste, value]
        end
      end
    end

    def options?
      !@options.empty?
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
