module Campfire
  class User
    attr_reader :id, :name, :email

    def initialize(manager, attributes)
      @manager = manager
      @id = attributes["id"]
      @name = attributes["name"]
      @email= attributes["email_address"]
    end

    def to_s
      %Q[User #{@id}: #{@name} (#{@email})]
    end
  end
end
