require "test_helper"

class TestManager < MiniTest::Unit::TestCase
  def test_initialization
    manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
    room    = Campfire::Room.new(manager, "id" => "1", "name" => "bar")

    assert_equal "1", room.id
    assert_equal "bar", room.name
    assert_nil room.topic
  end

  def test_string_representation_with_empty_topic
    room = Campfire::Room.new(nil, "id" => "1", "name" => "bar")
    assert_equal "Room 1: bar", room.to_s
  end

  def test_string_representation_with_topic
    room = Campfire::Room.new(nil, "id" => "1", "name" => "bar", "topic" => "foo")
    assert_equal "Room 1: bar (foo)", room.to_s
  end

  def test_join
    manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
    room    = manager.rooms.first

    response = room.join
    assert response
    assert_equal 200, response.code
  end
end
