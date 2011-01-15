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

    # TODO: validate blank search
    def search(term)
      @connection.get("/search/#{term}.json")["messages"].map do |message|
        room = Room.new(self, "id" => message["room_id"])
        Message.new(room, message)
      end
    end

    private

    def find_rooms(path)
      @connection.get("/#{path}.json")["rooms"].map do |room|
        Room.new(self, room)
      end
    end
  end
end
