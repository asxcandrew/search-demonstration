require 'singleton'

class Console
  include Singleton

  def print(string = '')
    puts(">>> #{string}")
  end

  def print_empty_line
    $stdout.write('>>> ')
  end

  def execute(command, params = nil)
    if Commands.list.include? command
      Commands.command_class(command).execute(params)
    else
      print('Invalid command')
      print_empty_line
    end
  end
end
