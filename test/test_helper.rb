require "rubygems"
require "bundler/setup"
Bundler.require :test

require "minitest/unit"
MiniTest::Unit.autorun

require "campfire"

def read_fixture(file_name)
  File.read(File.expand_path("../fixtures/#{file_name}", __FILE__))
end

WebMock.disable_net_connect!
WebMock.stub_request(:get, %r[http://123:X@.*\.campfirenow\.com/rooms\.json]).
        to_return(:body => read_fixture("rooms.json"), :headers => { "Content-Type" => "application/json" })
WebMock.stub_request(:get, %r[http://123:X@.*\.campfirenow\.com/presence\.json]).
        to_return(:body => read_fixture("presence.json"), :headers => { "Content-Type" => "application/json" })
