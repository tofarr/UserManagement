class Search::TagMutexSearch < Search

  #attr_accessor :tag_ids

  def initialize(hash = {}, enforce_limit = true)
    hash = hash.present? ? hash.as_json.deep_symbolize_keys : {}
    initializeFromSymbols(hash)
    #self.tag_ids = hash[:tag_ids].present? ? hash[:tag_ids].reject{|v| v.empty? }.map{|v| v.to_i } : nil
  end

  def search
    filter(results: TagMutex.all, filter_attrs: [])
  end

  def filter(hash)
    results = super(hash)
    #results = results.joins(:tags).where(tags: {id: tag_ids}) unless tag_ids.blank?
    results
  end
end
