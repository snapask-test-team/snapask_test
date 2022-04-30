class JsonWebToken
  # SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  SECRET_KEY = Rails.application.credentials.jwt_key.to_s

  def self.encode(payload)
    payload[:iat] = (DateTime.current).to_i
    payload[:exp] = (DateTime.current+30.days).to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
    HashWithIndifferentAccess.new decoded
  end
end
