module Campfire
  class Manager
    attr_reader :connection

    def initialize(options)
      @connection = Connection.new(options)
    end

    def rooms
      find_rooms 'rooms'
    end

    def presence
      find_rooms 'presence'
    end

    private

    def find_rooms(path)
      @connection.get("/#{path}.json")["rooms"].map do |room|
        Room.new(self, room)
      end
    end
  end
end
