class Tag < ApplicationRecord

  has_one_attached :icon
  has_many :user_tags, dependent: :destroy

  validates :code, presence: true, format: { with: /\A[a-z0-9_]+\z/ }
  validates :title, presence: true
  validates :icon, allow_blank: true, blob: { content_type: :image }
  validates :immutable, inclusion: { in: [ false ] }, on: :update

  before_validation Proc.new{ |t| t.apply_only_by_admin = true if t.grants_admin }
  before_validation Proc.new{ |t| t.code = t.title.parameterize.underscore if t.code.blank? && t.title.present? }

  def destroy
    raise "Cannot delete immutable" if immutable
    super
  end

  def update
    raise "Cannot update immutable" if immutable
    super
  end
end
