class FetchCountryFromIP
  class LookupFailed < StandardError; end

  def self.build
    new
  end

  def call(order)
    ip_address = order.ip_address
    response = HTTParty.get("http://ipinfo.io/#{ip_address}/json")
    raise(LookupFailed, response.to_s) if response.code != 200
    order.update!(country_from_ip: response.fetch("country", nil))
  end
end
