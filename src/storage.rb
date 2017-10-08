class Storage
  def initialize(provider = 'search_tree')
    @provider = provider
    @@storage ||= init_storage
  end

  def self.insert(*args)
    @@storage.insert(*args)
  end

  def self.find(*query)

    @@storage.find(*args)    
  end

  private

  def process_query(query)
    if query.include?('OR')
      {or: split_query(query, 'OR')}
    elsif query.include?('AND')
      {and: split_query(query, 'AND')}
    else
      {any: query}
    end
  end

  def init_storage
    Object.const_get("Storage::#{@provider.split('_').map(&:capitalize).join}").new
  end

  def split_query(query, delimiter)
    query.split(/#{Regexp.quote(delimiter)}/, 2).map(&:strip).reject(&:empty?)
  end
end
