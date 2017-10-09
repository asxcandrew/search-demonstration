class Commands::Index < Commands::Base
  def execute
    Dir[Dir.pwd + '/raw/*'].each do |file|
      file = File.open(file)

      begin
        file.read.gsub(/\r\n?/, "\n").each_line do |line|
          line.split(/\W+/).each do |word|
            Storage.insert(word.downcase, File.basename(file)) if word.length > 1
          end
        end
        Console.print(file.path)
      rescue
        Console.print("Something wrong occurred during reading file: #{file.path}")
      ensure
        file.close unless file.nil?
      end
    end
    Console.print_empty_line
  end

  def self.description
      '"index" - Build b-tree index from raw files.'
  end
end
