require "test_helper"

class TestCli < MiniTest::Unit::TestCase
  def test_valid_shortcuts_for_argv
    cli = Campfire::Cli.new(%w[-s foo -t 123])

    assert_equal "foo", cli.options[:subdomain]
    assert_equal "123", cli.options[:token]
  end

  def test_valid_normal_options_for_argv
    cli = Campfire::Cli.new(%w[--subdomain foo --token 123])

    assert_equal "foo", cli.options[:subdomain]
    assert_equal "123", cli.options[:token]
  end

  def test_invalid_option_raises_error
    assert_raises OptionParser::InvalidOption do
      Campfire::Cli.new(%w[-x foo])
    end
  end

  def test_blank_option_raises_error
    assert_raises OptionParser::MissingArgument do
      Campfire::Cli.new([])
    end
  end

  def test_missing_required_option
    assert_raises OptionParser::MissingArgument do
      Campfire::Cli.new(%w(-s foo))
    end
  end

  def test_default_command
    cli = Campfire::Cli.new(%w[-s foo -t 123])
    assert_equal :rooms, cli.options[:command]
  end

  def test_rooms_command
    cli = Campfire::Cli.new(%w[-s foo -t 123 --rooms])
    assert_equal :rooms, cli.options[:command]
  end

  def test_run_executes_the_given_command
    cli = Campfire::Cli.new(%w[-s foo -t 123 --rooms])

    rooms = cli.run!
    assert_equal 2, rooms.size
    assert_instance_of Campfire::Room, rooms.first
  end
end
