class Commands
    def self.execute(*args)
      service = new(*args)
  
      service.send(:execute)
    end

    private

    def initialize(*args)
    end
  
    def execute
      raise NotImplementedError
    end
  end
