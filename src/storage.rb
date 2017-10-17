class Storage
  def initialize(provider = 'search_tree')
    @provider = provider
    @@storage ||= init_storage
    @@instance ||= self
  end

  class << self
    def to_json
      @@storage.to_json
    end

    def insert(*args)
      @@storage.insert(*args)
    end
  
    def find(query)
      @@instance.find(query)
    end

    def restore_from_json(body)
      @@storage.restore(JSON.parse(body))
    end
  end

  def find(query)
    transformed_query = transform_query(query.join(' '))
    res = transformed_query.values.first.map do |item|
      Hash[item, @@storage.find(item)]
    end

    Storage::Response.new(transform_response(transformed_query.keys.first, res, query), query)
  end

  private

  def transform_response(operator, res, query)
    if operator == :and
      common = res.map{ |i| i.values.first.keys }.inject(:&)
      [Hash[query.join(' '), common]]
    else
      res
    end
  end

  def transform_query(query)
    if query.include?('AND')
      {and: query.split(/AND/, 2).map(&:strip).reject(&:empty?)}
    else
      {any: query.split(/\s/)}
    end
  end

  def init_storage
    Object.const_get("Storage::#{@provider.split('_').map(&:capitalize).join}").new
  end
end
