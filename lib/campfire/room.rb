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

    def join
      @manager.connection.post "/room/#{@id}/join.json"
    end
  end
end
