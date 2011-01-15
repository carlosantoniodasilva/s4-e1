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

    def to_s
      %Q[Message #{id}: #{@body} (#{human_type} - #{human_created_at})]
    end

    private

    def human_type
      @type.gsub("Message", "")
    end

    def human_created_at
      @created_at.gsub(/ \+.*/, "")
    end
  end
end
