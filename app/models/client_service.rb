class ClientService < ApplicationRecord

  def self.algorithms
     %w(HS256 HS384 HS512 RS256 RS384 RS512)
  end

  def self.key_for(key, algorithm, decode = false)
    case algorithm
      when "HS256", "HS384", "HS512"
        key
      when "RS256", "RS384", "RS512"
        rsa_key = OpenSSL::PKey::RSA.new secret_key
        decode ? rsa_key.public_key : rsa_key
    end
  end

  belongs_to :tag
  has_one_attached :icon

  validates :title, presence: true
  validates :secret_key, presence: true
  validates :algorithm, presence: true, inclusion: { in: algorithms }
  validates :login_redirect, presence: true
  validates :icon, allow_blank: true, blob: { content_type: :image }

  after_initialize :set_secret_key_default

  def active?
    return false if suspended?
    return (DateTime.now < expire_at) if expire_at.present?
    true
  end

  def user_access_url(user)
    token_access_url(encode_jwt_token(user))
  end

  def token_access_url(token)
    login_redirect.gsub("<CLIENT_SERVICE_ID>", id.to_s).gsub("<TOKEN>", token)
  end

  def encode_jwt_token(user)
    key = ClientService.key_for(secret_key, algorithm)
    token = Token.new(user, token_timeout)
    encode_jwt(key, token.as_json)
  end

  def decode_jwt_token(token)
    key = ClientService.key_for(secret_key, algorithm, true)
    Token.new(decode_jwt(key, token)[0].with_indifferent_access)
  end

  def decode_jwt_request(request)
    key = ClientService.key_for(remote_public_key || secret_key, algorithm, true)
    decode_jwt(key, request)
  end

  def encode_jwt(key, payload)
    JWT.encode payload, key, algorithm
  end

  def decode_jwt(key, payload)
    JWT.decode payload, key, algorithm
  end

  private

    def set_secret_key_default
      return if secret_key.present? || (!has_attribute?(:secret_key)) || (!has_attribute?(:algorithm))
      case algorithm
        when "HS256", "HS384", "HS512"
          self.secret_key = SecureRandom.base64(44)
        when "RS256", "RS384", "RS512"
          self.secret_key = OpenSSL::PKey::RSA.generate(2048).to_pem
      end
    end

end
