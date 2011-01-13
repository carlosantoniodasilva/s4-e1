require "test_helper"

class TestConnection < MiniTest::Unit::TestCase
  def setup
    @connection = Campfire::Connection.new(:subdomain => "foo", :token => "123")
  end

  def test_initialization
    assert_equal "foo", @connection.subdomain
    assert_equal "123", @connection.token
  end

  def test_get_returns_parsed_json
    WebMock.stub_request(:get, %r[foo.campfirenow.com/bar.json]).
      to_return(:body => '{"success":1}', :headers => { "Content-Type" => "application/json" })

    response = @connection.get("/bar.json")
    assert_equal 1, response["success"]
  end
end
