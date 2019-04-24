class User < ApplicationRecord
  validates :user_name, presence: true, format: { with: /\A[a-z0-9_]+\z/ }
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password validations: false
  has_one_attached :avatar
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags

  before_validation :init_user_name

  def settings
    JSON.parse(read_attribute(:settings))
  end

  def settings=(value)
    write_attribute(:settings, value&.to_json)
  end

  def admin?
    @admin ||= tags.where(grants_admin: true).select(:id).first.present?
  end

  private
    def init_user_name
      if user_name.blank?
        if email.present?
          self.user_name = email.split('@').first
        elsif full_name.present?
          self.user_name = full_name.parameterize.underscore
        end
      end
    end

end
