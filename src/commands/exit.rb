class Commands::Exit < Commands
    def execute
        exit
    end

    def description
        '"exit" - interrupt the program.'
    end
end
