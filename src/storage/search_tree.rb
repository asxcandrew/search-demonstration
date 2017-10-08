class Storage::SearchTree
  class Node < Storage::SearchTree
    attr_accessor :key, :childs, :data, :parent

    def initialize(source, filename, ancestor = nil)
      @childs = {}
      @data = {}
      @parent = ancestor
      @key = source[0]
      insert(source, filename)
    end

    def insert(source, filename)
      if source.length > 0
        child_key = source[0]

        if childs[child_key]
          childs[child_key].insert(source[1..-1], filename)
        else
          childs[child_key] = Node.new(source[1..-1], filename, self)
        end
      else
        data.tap do |item|
          if item[filename]
            item[filename] = item[filename] + 1
          else
            item[filename] = 1
          end
        end
      end
    end
  end

  def initialize
    @childs = {}
  end

  def find(word)
    if word.length > 0
      if @childs[word[0]]
        @childs[word[0]].find(word[1..-1])
      else
        {}
      end
    else
      @data
    end
  end

  def insert(word, filename)
    if @childs[word[0]]
      @childs[word[0]].insert( word[1..-1], filename )
    else
      @childs[word[0]] = Node.new( word[1..-1], filename )
    end
  end
end
