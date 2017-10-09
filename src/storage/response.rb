class Storage::Response
  def initialize(data, query)
    @data = data
    @query = query
  end

  def words
    @data.map{|i| i.keys.first}
  end

  def word_files(word)
    word = find_word(word)[word]

    if word.is_a?(Hash)
      word.sort_by{|_key, value| -value}.to_h.keys
    else
      word
    end
  end

  def word_file_count(word, file)
    find_word(word)[word][file]
  end

  def query
    @query
  end

  private

  def find_word(word)
    @data.find{|i| i.key?(word)}
  end
end
