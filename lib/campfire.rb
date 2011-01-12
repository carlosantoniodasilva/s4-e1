require "rubygems"
require "bundler/setup"
Bundler.require

module Campfire
  autoload :Cli,        "campfire/cli"
  autoload :Connection, "campfire/connection"
  autoload :Manager,    "campfire/manager"
  autoload :Room,       "campfire/room"
end
