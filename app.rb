require './src/console.rb'
require_relative 'src/commands'
require_relative 'src/storage'

require 'pry'

Dir[File.dirname(__FILE__) + '/src/**/*.rb'].each do |file|
  require file
end

Storage.new()

Commands.execute('help')

loop do
  input = gets.chomp
  command, *params = input.split /\s/

  Console.execute(command, params)
end
