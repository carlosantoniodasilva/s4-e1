module Campfire
  class Message
    attr_reader :id, :type, :created_at, :body

    def initialize(room, attributes)
      @room = room
      @id   = attributes["id"]
      @type = attributes["type"]
      @body = attributes["body"]
      @created_at = attributes["created_at"]
    end
  end
end
