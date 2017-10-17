class Commands::Index < Commands::Base
  def initialize(path)
    @path = path
  end

  def execute
    begin
      file = File.open(@path)

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

    File.open('index.json', 'w+') {|f| f.write(Storage.to_json) }
  end

  def self.description
      '"index" - Build b-tree index from raw files.'
  end
end
