require "test_helper"

class TestManager < MiniTest::Unit::TestCase
  def test_initialization
    manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
    room    = Campfire::Room.new(manager, "id" => "1", "name" => "bar")

    assert_equal "1", room.id
    assert_equal "bar", room.name
    assert_nil room.topic
  end
end
