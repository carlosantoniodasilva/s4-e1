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
  end
end
