require './src/console.rb'
require './src/commands.rb'
require_relative 'src/storage'

require 'pry'

Dir[File.dirname(__FILE__) + '/src/storage/*.rb'].each do |file|
  require file
end

Storage.new()

Console.instance.print_empty_line

loop do
  input = gets.chomp
  command, *params = input.split /\s/

  Console.instance.execute(command, params)
end
