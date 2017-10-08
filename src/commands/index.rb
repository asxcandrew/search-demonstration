class Commands::Index < Commands
    def execute
      Dir[Dir.pwd + '/raw/*'].each do |file|
        Console.instance.print(file)

        file = File.open(file)

        if file.external_encoding.name == 'UTF-8'
          file.read.gsub(/\r\n?/, "\n").each_line do |line|
            line.split(/\W+/).each do |word|
              Storage.instance.insert(word.downcase, File.basename(file)) if word.length > 1
            end
          end
        end
      end
      Console.instance.print_empty_line
    end

    def description
        '"index" - build index table from raw files.'
    end
end
