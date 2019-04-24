
class Search

  ATTRS = [:query, :page_size, :page_index, :max_id, :ids, :sort_order]
  attr_accessor(*ATTRS)

  def initialize(hash = {})
    initializeFromSymbols(hash = hash.present? ? hash.as_json.deep_symbolize_keys : {})
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

  def filter(hash)
    results = hash[:results]
    filter_attrs = hash[:filter_attrs]
    permitted_orders = hash[:permitted_orders]
    permitted_orders = filter_attrs + [:id, :created_at, :updated_at] if permitted_orders.blank?
    enforce_limit = hash[:enforce_limit]
    enforce_limit = true if enforce_limit.nil?

    results = apply_query(results, filter_attrs)
    results = apply_sort_orders(results, permitted_orders)
    results = apply_paging(results, enforce_limit)
  end

  def apply_ids(results)
    results = results.where(id: ids) if ids.present?
    results
  end

  def apply_query(results, filter_attrs)
    return results unless query.present?
    raise ApplicationController::BadRequest.new() if filter_attrs.blank?
    filter_attrs.inject(results) do |results, filter_attr|
      results.where("#{filter_attr} like ?", "%#{query}%")
    end
  end

  def apply_sort_orders(results, permitted_orders)
    if sort_order.blank?
      results
    elsif sort_order.is_a?(String)
      apply_sort_order(results, sort_order, false)
    else
      sort_order.inject(results) do |results, k, v|
        apply_sort_order(results, k, v)
      end
    end
  end

  def apply_sort_order(results, attr, desc)
    attr = attr.to_sym
    desc = desc.to_sym == :desc
    raise ApplicationController::NotAuthorized.new() unless permitted_orders.include(attr)
    orders = {}
    orders[attr] = desc ? :desc : :asc
    results.orders(orders)
  end

  def apply_paging(results, enforce_limit)
    results = results.where("id < ?", max_id) if max_id.present?
    return results if self.page_size.blank?
    results = results.offset(page_size * (page_index || 0)) if page_index.present?
    results.limit(page_size)
  end

  def default_search?(current_user)
    query.blank? && sort_order.blank? && ids.blank? &&
      min_id.blank? && (page_index.blank? || page_index.to_i == 0)
  end

end
