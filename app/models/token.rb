
class Token

  ATTRS = [:user_id, :tags, :exp]
  attr_accessor(*ATTRS)

  def initialize(hash = {}, timeout = nil)
    if (hash.is_a?(User))
      self.user_id = hash.id
      self.tags = hash.tags.select(:code).map(&:code)
      self.exp = DateTime.now.to_i + timeout if timeout.present?
    else
      self.user_id = hash[:user_id]
      self.tags = hash[:tags]
      self.exp = hash[:exp]
    end
  end

  def initializeFromSymbols(hash)
    ATTRS.each { |a| send("#{a}=", hash[a]) }
    self.ids.reject!{|v| v.empty? }.map{|v| v.to_i } if ids.present?
    if page_size.present?
      self.page_size = page_size.to_i
      raise ApplicationController::BadRequest.new() if (page_size <= 0)
      raise ApplicationController::BadRequest.new() if (hash[:enforce_limit] != false) && (page_size > Rails.configuration.max_page_size)
    end
    self.ids = ids.reject{|v| v.empty? }.map{|v| v.to_i } if ids.present?
    self.page_size = page_size.present? ? page_size.to_i : Rails.configuration.max_page_size
    self.page_index = page_index.to_i if page_index.present?
  end

end
