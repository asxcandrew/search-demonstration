require 'singleton'

class Console
  include Singleton

  def initialize
    Dir[File.dirname(__FILE__) + '/commands/*.rb'].each do |file|
      commands << File.basename(file,'.*')
      require file
    end
  end

  def print(string = '')
    puts(">>> #{string}")
  end

  def print_empty_line
    $stdout.write('>>> ')
  end

  def execute(command, params = nil)
    if commands.include? command
      command_class(command).execute(params)
    else
      print('Invalid command')
      print_empty_line
    end
  end

  private
  
  def command_class(command)
    Object.const_get("Commands::#{command.capitalize}")
  end

  def commands
    @commands ||= []
  end
end
