require "test_helper"

class TestRoom < MiniTest::Unit::TestCase
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

  def test_recent_messages
    manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
    room    = manager.rooms.first

    messages = room.recent
    assert_equal 4, messages.size

    message = messages[0]
    assert_equal "TimestampMessage", message.type
    assert_equal "2011/01/13 01:05:00 +0000", message.created_at
    assert_nil message.body

    message = messages[2]
    assert_equal "TextMessage", message.type
    assert_equal "2011/01/13 01:05:46 +0000", message.created_at
    assert_equal "Hello World!", message.body
  end

  def test_join
    manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
    room    = manager.rooms.first

    response = room.join
    assert response
    assert_equal 200, response.code
  end

  def test_leave
    manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
    room    = manager.rooms.first

    response = room.leave
    assert response
    assert_equal 200, response.code
  end
end
