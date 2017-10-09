require './src/console.rb'
require_relative 'src/commands'
require_relative 'src/storage'

require 'pry'

Dir[File.dirname(__FILE__) + '/src/storage/*.rb'].each do |file|
  require file
end
Dir[File.dirname(__FILE__) + '/src/commands/*.rb'].each do |file|
  require file
end

Storage.new()

Commands.command_class('help').execute

loop do
  input = gets.chomp
  command, *params = input.split /\s/

  Console.execute(command, params)
end
