module Commands
  LIST = %w(exit help index search).freeze

  def self.list
    LIST
  end

  def self.execute(command, params = nil)
    command_class(command).execute(params)
  end

  def self.command_class(command)
    Object.const_get("Commands::#{command.capitalize}")
  end
end
