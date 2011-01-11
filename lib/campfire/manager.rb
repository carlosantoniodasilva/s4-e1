module Campfire
  class Manager
    def initialize(options)
      @connection = Connection.new(options)
    end

    def rooms
      @connection.get("/rooms.json")["rooms"].map do |room|
        Room.new(self, room)
      end
    end
  end
end
