class Commands::Exit < Commands::Base
  def execute
    exit
  end

  def self.description
    '"exit" -Iinterrupt the program.'
  end
end
