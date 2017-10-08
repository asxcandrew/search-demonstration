class Commands::Search < Commands
  def initialize(words)
    @words = words
  end

  def execute
    print_result(result)
  end

  def description
    '"search" - .'
  end

  private

  def result
    {}.tap do |result|
      @words.each do |word|
        result[word.to_sym] = Storage.instance.find(word)
      end
    end
  end

  def print_result(result)
    result.each_with_index do |(key,data),index|
      Console.instance.print("#{index+1}. Searching for '#{key}' ...")
      Console.instance.print('Found in:')
      data.sort_by{|_key, value| -value}.each do |file, number|
        Console.instance.print("   #{file} #{number} times")        
      end
    end
    Console.instance.print_empty_line
  end
end
