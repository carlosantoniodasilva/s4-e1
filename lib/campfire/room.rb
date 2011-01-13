module Campfire
  class Room
    attr_reader :id, :name, :topic

    def initialize(manager, attributes)
      @manager = manager
      @id      = attributes["id"]
      @name    = attributes["name"]
      @topic   = attributes["topic"]
    end

    def to_s
      %Q[Room #{@id}: #{@name}#{" (#{@topic})" if @topic}]
    end

    def recent
      get("recent")["messages"].map do |message|
        Message.new(self, message)
      end
    end

    def join
      post "join"
    end

    def leave
      post "leave"
    end

    private

    def get(action)
      @manager.connection.get room_url(action)
    end

    def post(action)
      @manager.connection.post room_url(action)
    end

    def room_url(action)
      "/room/#{@id}/#{action}.json"
    end
  end
end
