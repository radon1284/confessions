class SecureToken
  ALGORITHM = 'HS256'.freeze

  def self.encode(payload, scope, expires)
    new.do_encode(payload, scope, expires)
  end

  def self.decode(token, scope)
    new.do_decode(token, scope)
  end

  def do_encode(payload, scope, expires)
    payload = payload.merge(
      sub: scope,
      exp: expires.to_i
    )

    JWT.encode(
      payload,
      hmac_secret,
      ALGORITHM
    )
  end

  def do_decode(token, scope)
    payload = decoded_payload(token, scope)
    [:ok, payload.except("sub", "exp").symbolize_keys]
  rescue JWT::ExpiredSignature
    [:expired, {}]
  rescue JWT::DecodeError
    [:invalid, {}]
  end

  private

  def hmac_secret
    Rails.application.secrets.secret_key_base
  end

  def decoded_payload(token, scope)
    payload, = JWT.decode(
      token,
      hmac_secret,
      true,
      algorithm: ALGORITHM,
      sub: scope,
      verify_sub: true
    )

    payload
  end
end
