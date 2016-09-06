require "rails_helper"

describe FetchCountryFromIP, :vcr do
  let!(:service) { FetchCountryFromIP.build }
  let!(:order) { FactoryGirl.create(:order, ip_address: "8.8.8.8") }

  it "saves the IP-based country to order" do
    expect { service.call(order) }
      .to change { order.reload.country_from_ip }
      .from(nil)
      .to("US")
  end
end
