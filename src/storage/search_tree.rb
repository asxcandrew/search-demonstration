class Storage::SearchTree
  class Node < Storage::SearchTree
    attr_accessor :key

    def initialize(source, filename)
      @childs = []
      @data = {}
      @key = source[0]
      insert(source[1..-1], filename)
    end

    def insert(source, filename)
      if source.length > 0
        insert_or_create_child(source, filename)
      else
        update_data(filename)
      end
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

  private

  def insert_or_create_child(word, filename)
    child = child_by_key(word[0])

    if child
      child.insert( word[1..-1], filename )
    else
      @childs << Node.new( word, filename )
    end
  end

  def child_by_key(key)
    @childs.find{|c| c.key == key}
  end
end
