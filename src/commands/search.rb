class Commands::Search < Commands::Base
  def initialize(query)
    @query = query
  end

  def execute
    print_result(result)
  end

  def self.description
    '"search [params]" - Serch provided query in previously built index'
  end

  private

  def print_result(result)
    result = Storage.find(@query)
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
