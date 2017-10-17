require_relative 'console'
require_relative 'commands'
require_relative 'storage'

Dir[File.dirname(__FILE__) + '/**/*.rb'].each do |file|
  require file
end

Storage.new()

index = File.dirname(File.expand_path('..', __FILE__)) + '/index.json'

unless File.zero?(index)
  Storage.restore_from_json(File.open(index).read)
end
