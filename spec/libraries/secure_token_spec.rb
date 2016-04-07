require "rails_helper"

describe SecureToken do
  context "when token is valid" do
    let!(:payload) { { user_id: 5 } }
    let!(:scope) { "some_scope" }
    let!(:expires) { 4.hours.from_now }

    it "decodes the token" do
      token = SecureToken.encode(payload, scope, expires)
      status, decoded_payload = SecureToken.decode(token, scope)
      expect(status).to eq :ok
      expect(decoded_payload).to eq payload
    end
  end

  context "when token is invalid" do
    let!(:scope) { "some_scope" }

    it "returns invalid status" do
      status, _decoded_payload = SecureToken.decode("invalid", scope)
      expect(status).to eq :invalid
    end
  end

  context "when token has expired" do
    let!(:payload) { { user_id: 5 } }
    let!(:scope) { "some_scope" }
    let!(:expires) { 4.hours.ago }

    it "returns expired status" do
      token = SecureToken.encode(payload, scope, expires)
      status, _decoded_payload = SecureToken.decode(token, scope)
      expect(status).to eq :expired
    end
  end

  context "when token was generated for different scope" do
    let!(:payload) { { user_id: 5 } }
    let!(:scope) { "some_scope" }
    let!(:different_scope) { "different_scope" }
    let!(:expires) { 4.hours.from_now }

    it "returns invalid status" do
      token = SecureToken.encode(payload, scope, expires)
      status, _decoded_payload = SecureToken.decode(token, different_scope)
      expect(status).to eq :invalid
    end
  end
end
