class Storage
  def initialize(provider = 'search_tree')
    @provider = provider
    @@storage ||= init_storage
  end

  def self.instance
    return @@storage
  end

  private
  
  def init_storage
    Object.const_get("Storage::#{@provider.split('_').map(&:capitalize).join}").new
  end
end
