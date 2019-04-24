class TagMutex < ApplicationRecord
  belongs_to :tag_a, class_name: 'Tag'
  belongs_to :tag_b, class_name: 'Tag'


  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverses
    self.class.where(inverse_match_options)
  end

  def inverse_match_options
    { tag_a_id: tag_b_id, tag_b_id: tag_a_id }
  end
end
