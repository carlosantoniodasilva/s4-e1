require "test_helper"

class TestUser < MiniTest::Unit::TestCase
  def setup
    @manager = Campfire::Manager.new(:subdomain => "foo", :token => "123")
  end

  def test_initialization
    user = Campfire::User.new(@manager,
      "id" => "1", "name" => "Carlos", "email_address" => "carlos@foo.bar")

    assert_equal "1", user.id
    assert_equal "Carlos", user.name
    assert_equal "carlos@foo.bar", user.email
  end

  def test_string_representation
    user = Campfire::User.new(@manager,
      "id" => "1", "name" => "Carlos", "email_address" => "carlos@foo.bar")

    assert_equal "User 1: Carlos (carlos@foo.bar)", user.to_s
  end
end
