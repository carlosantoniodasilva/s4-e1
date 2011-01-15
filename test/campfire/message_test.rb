require "test_helper"

class TestMessage < MiniTest::Unit::TestCase
  def test_initialization
    room    = Campfire::Room.new(nil, "id" => "1")
    message = Campfire::Message.new(room, "id" => "1",
      "type" => "TextMessage", "body" => "Hello!", "created_at" => "2011/01/13 01:05:49 +0000")

    assert_equal "1", message.id
    assert_equal "Hello!", message.body
    assert_equal "TextMessage", message.type
    assert_equal "2011/01/13 01:05:49 +0000", message.created_at
  end
end
