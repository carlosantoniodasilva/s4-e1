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
WebMock.stub_request(:get, "https://123:X@foo.campfirenow.com/rooms.json").
        to_return(:body => read_fixture("rooms.json"), :headers => { "Content-Type" => "application/json" })
WebMock.stub_request(:get, "https://123:X@foo.campfirenow.com/presence.json").
        to_return(:body => read_fixture("presence.json"), :headers => { "Content-Type" => "application/json" })

WebMock.stub_request(:post, "https://123:X@foo.campfirenow.com/room/214394/join.json").
        to_return(:status => 200, :headers => { "Content-Type" => "application/json" })
WebMock.stub_request(:post, "https://123:X@foo.campfirenow.com/room/214394/leave.json").
        to_return(:status => 200, :headers => { "Content-Type" => "application/json" })
