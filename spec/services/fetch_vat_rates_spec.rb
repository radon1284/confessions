require "rails_helper"

describe FetchVATRates, :vcr do
  let!(:service) { FetchVATRates.build }
  let!(:date) { Time.zone.local(2016, 9, 10) }

  it "stores the response in the database" do
    expect { service.call(date) }
      .to change { VATRateResponse.count }
      .by(1)
  end
end
