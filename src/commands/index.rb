class Commands::Index < Commands::Base
  def execute
    Dir[Dir.pwd + '/raw/*'].each do |file|
      Console.print(file)

      file = File.open(file)

      if file.external_encoding.name == 'UTF-8'
        file.read.gsub(/\r\n?/, "\n").each_line do |line|
          line.split(/\W+/).each do |word|
            Storage.insert(word.downcase, File.basename(file)) if word.length > 1
          end
        end
      end
    end
    Console.print_empty_line
  end

  def self.description
      '"index" - Build b-tree index from raw files.'
  end
end
