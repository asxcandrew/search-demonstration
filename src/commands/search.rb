class Commands::Search < Commands::Base
  def initialize(query)
    @query = query
  end

  def execute
    result_object = Storage.find(@query)
    print_result(result_object)
  end

  def self.description
    '"search [params]" - Serch provided query in previously built index'
  end

  private

  def print_result(result_object)
    result_object.words.each_with_index do |word,index|
      Console.print("#{index+1}. Searching for '#{word}' ...")
      if result_object.word_files(word).any?
        Console.print('Found in:')

        result_object.word_files(word).each do |file|
          Console.print("   #{file}")
        end
      else
        Console.print('No matches found.')
      end
    end
    Console.print_empty_line
  end
end
