require "test_helper"

class TestManager < MiniTest::Unit::TestCase
  def test_rooms
    manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
    rooms   = manager.rooms

    room = rooms[0]
    assert_equal "Room 1", room.name
    assert_equal 214394, room.id
    assert_nil room.topic

    room = rooms[1]
    assert_equal "Room 2", room.name
    assert_equal 214395, room.id
    assert_equal "RMU", room.topic
  end
end
