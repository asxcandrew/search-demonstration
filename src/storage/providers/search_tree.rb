require 'json/ext'

class Storage::SearchTree
  class Node < Storage::SearchTree
    attr_accessor :key, :data

    def initialize()
      @childs = []
      @data = {}
    end

    def insert(source, filename)
      if source.length > 0
        insert_or_create_child(source, filename)
      else
        update_data(filename)
      end
    end

    def to_json
      {c: @childs.map(&:to_json), k: @key, d: @data}
    end

    private

    def update_data(key)
      @data.tap do |item|
        if item[key]
          item[key] = item[key] + 1
        else
          item[key] = 1
        end
      end
    end
  end

  def initialize
    @childs = []
  end

  def find(word)
    if word.length > 0
      child = child_by_key(word[0])

      if child
        child.find(word[1..-1])
      else
        {}
      end
    else
      @data
    end
  end

  def insert(word, filename)
    insert_or_create_child(word, filename)
  end

  def to_json
    {c: @childs.map(&:to_json)}.to_json
  end

  def restore(struct)
    struct['c'].each do |child_data|
      child = Node.new
      child.key = child_data['k']
      child.data = child_data['d']
      child.restore(child_data)

      @childs << child
    end
  end

  private

  def insert_or_create_child(word, filename)
    child = child_by_key(word[0])

    unless child
      child = Node.new
      child.key = word[0]
      @childs << child
    end

    child.insert(word[1..-1], filename)
  end

  def child_by_key(key)
    @childs.find{|c| c.key == key}
  end
end
