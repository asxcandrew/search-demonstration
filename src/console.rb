module Console
  def self.print(string = '')
    puts(">>> #{string}")
  end

  def self.print_empty_line
    $stdout.write('>>> ')
  end

  def self.execute(command, params = nil)
    if Commands.list.include? command
      Commands.command_class(command).execute(params)
    else
      print('Invalid command')
      print_empty_line
    end
  end
end
