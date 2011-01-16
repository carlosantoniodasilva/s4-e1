require "test_helper"

class TestCli < MiniTest::Unit::TestCase
  def test_valid_shortcuts_for_argv
    cli = Campfire::Cli.new(%w[-s foo -t 123 --rooms])

    assert_equal "foo", cli.options[:subdomain]
    assert_equal "123", cli.options[:token]
  end

  def test_valid_normal_options_for_argv
    cli = Campfire::Cli.new(%w[--subdomain foo --token 123 --rooms])

    assert_equal "foo", cli.options[:subdomain]
    assert_equal "123", cli.options[:token]
  end

  def test_invalid_option_raises_error
    assert_raises OptionParser::InvalidOption do
      Campfire::Cli.new(%w[-x foo])
    end
  end

  def test_required_options
    assert_raises OptionParser::MissingArgument do
      Campfire::Cli.new(%w(-s foo))
    end

    assert_raises OptionParser::MissingArgument do
      Campfire::Cli.new(%w(-t 123))
    end

    assert_raises OptionParser::MissingArgument do
      Campfire::Cli.new(%w(-s foo -t 123))
    end
  end

  def test_rooms_command_options
    cli = Campfire::Cli.new(%w[-s foo -t 123 --rooms])
    assert_equal :rooms, cli.options[:command]
  end

  def test_presence_command_options
    cli = Campfire::Cli.new(%w[-s foo -t 123 --presence])
    assert_equal :presence, cli.options[:command]
  end

  def test_search_command_options
    cli = Campfire::Cli.new(%w[-s foo -t 123 --search foo])
    assert_equal [:search, "foo"], cli.options[:command]
  end

  def test_me_command_options
    cli = Campfire::Cli.new(%w[-s foo -t 123 --me])
    assert_equal :me, cli.options[:command]
  end

  def test_room_command_options
    cli = Campfire::Cli.new(%w(-s foo -t 123 --room 123 --speak foo))
    assert_equal [:room, 123], cli.options[:command]
  end

  def test_speak_into_room_command_options
    cli = Campfire::Cli.new(%w(-s foo -t 123 --room 123 --speak foo))
    assert_equal [:speak, "foo"], cli.options[:subcommand]
  end

  def test_paste_into_room_command_options
    cli = Campfire::Cli.new(%w(-s foo -t 123 --room 123 --paste foo))
    assert_equal [:paste, "foo"], cli.options[:subcommand]
  end

  def test_run_executes_the_given_command
    cli = Campfire::Cli.new(%w[-s foo -t 123 --rooms])

    rooms = cli.run
    assert_equal 2, rooms.size
    assert_instance_of Campfire::Room, rooms.first
  end

  def test_run_executes_the_given_command_with_subcommand
    cli = Campfire::Cli.new(%w(-s foo -t 123 --room 214394 --speak hello\ world!))

    message = cli.run
    assert_equal "hello world!", message.body
  end

  def test_help
    cli = Campfire::Cli.new([])

    help_message = cli.run
    assert_match /Campfire Command Line Tool/, help_message
    assert_match /--rooms/, help_message
    assert_match /--search.*Search the given term/, help_message
    assert_match /--speak/, help_message
  end
end
