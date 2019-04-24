class Search::UserTagSearch < Search

  attr_accessor :tag_id, :user_id

  def initialize(hash = {}, enforce_limit = true)
    hash = hash.present? ? hash.as_json.deep_symbolize_keys : {}
    initializeFromSymbols(hash)
    self.user_id = hash[:user_id].present? ? hash[:user_id].to_i : nil
    self.tag_id = hash[:tag_id].present? ? hash[:tag_id].to_i : nil
  end

  def search
    filter(results: UserTag.all, filter_attrs: [], permitted_orders: [:id, :tag_id, :user_id, :created_at, :updated_at])
  end

  def filter(hash)
    results = super(hash)
    results = results.where(user_id: user_id) unless user_id.blank?
    results = results.where(tag_id: tag_id) unless tag_id.blank?
    results
  end
end
