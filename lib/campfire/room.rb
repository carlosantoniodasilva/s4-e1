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

    # TODO: handle failing cases of speak
    def speak(message_text)
      message = post("speak", :message => { :body => message_text, :type => "TextMessage" })
      Message.new(self, message)
    end

    def paste(paste_text)
      message = post("speak", :message => { :body => paste_text, :type => "PasteMessage" })
      Message.new(self, message)
    end

    private

    def get(action)
      @manager.connection.get room_url(action)
    end

    def post(action, body=nil)
      @manager.connection.post room_url(action), body
    end

    def room_url(action)
      "/room/#{@id}/#{action}.json"
    end
  end
end
