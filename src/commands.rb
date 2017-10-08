module Commands
  LIST = %w(exit help index search).freeze

  def self.list
    LIST
  end

  def self.command_class(command)
    Object.const_get("Commands::#{command.capitalize}")
  end
end
