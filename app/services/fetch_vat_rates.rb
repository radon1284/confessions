class FetchVATRates
  API_URL = "http://apilayer.net/api/rate_list".freeze

  def self.build
    new
  end

  def call(date)
    VATRateResponse.create!(
      date: date.beginning_of_day,
      payload: api_response
    )
  end

  private

  def api_response
    HTTParty.get(
      API_URL,
      query: {
        access_key: ENV.fetch("VATLAYER_API_KEY")
      }
    )
  end
end
