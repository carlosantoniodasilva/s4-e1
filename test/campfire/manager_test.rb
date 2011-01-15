require "test_helper"

class TestManager < MiniTest::Unit::TestCase
  def setup
    @manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
  end

  def test_rooms
    rooms = @manager.rooms
    assert_equal 2, rooms.size

    room = rooms[0]
    assert_equal "Room 1", room.name
    assert_equal 214394, room.id
    assert_nil room.topic

    room = rooms[1]
    assert_equal "Room 2", room.name
    assert_equal 214395, room.id
    assert_equal "RMU", room.topic
  end

  def test_presence_rooms
    rooms = @manager.presence
    assert_equal 1, rooms.size

    room = rooms[0]
    assert_equal "Room 2", room.name
    assert_equal 214395, room.id
    assert_equal "RMU", room.topic
  end

  def test_search
    messages = @manager.search("hello")
    assert_equal 3, messages.size

    message = messages[0]
    assert_equal "Hello World!", message.body
    assert_equal "TextMessage", message.type

    message = messages[1]
    assert_equal "Other Hello World!", message.body
    assert_equal "TextMessage", message.type

    message = messages[2]
    assert_equal "More One Hello World!", message.body
    assert_equal "TextMessage", message.type
  end
end
