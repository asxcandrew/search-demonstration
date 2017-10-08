class Commands::Help < Commands::Base
  def execute
    Commands.list.each do |command|
      Console.instance.print(Commands.command_class(command).description)
    end
    Console.instance.print_empty_line
  end

  def self.description
    '"help" - Display commands descriptions.'
  end
end
