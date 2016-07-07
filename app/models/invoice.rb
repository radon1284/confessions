class Invoice
  SELLER_NAME = "Jack Kinsella (sole trader)".freeze
  SELLER_ADDRESS = "Graefestr 78\n10967 Berlin".freeze
  SELLER_COUNTRY = "Germany".freeze
  SELLER_VAT_ID = "DE287747520".freeze
  VAT_RATE_FOR_BUSINESS_CUSTOMERS = "n/a".freeze
  VAT_AMOUNT_FOR_BUSINESS_CUSTOMERS = "0.00".freeze

  def initialize(order:, invoice_request:)
    self.order = order
    self.invoice_request = invoice_request
  end

  def invoice_number
    order.invoice_number
  end

  def date_of_issue
    order.created_at
  end

  def payment_status
    "paid"
  end

  def seller_name
    SELLER_NAME
  end

  def seller_address
    SELLER_ADDRESS
  end

  def seller_country
    SELLER_COUNTRY
  end

  def seller_vat_id
    SELLER_VAT_ID
  end

  def buyer_name
    invoice_request.company_name
  end

  def buyer_address
    invoice_request.address
  end

  def buyer_country
    invoice_request.country
  end

  def buyer_vat_id
    invoice_request.vat_id
  end

  def display_buyer_vat_id?
    buyer_vat_id.present?
  end

  def total
    "#{order.total} #{order.total.currency}"
  end

  def items
    order.order_items.map do |order_item|
      Item.new(order_item)
    end
  end

  def reverse_charge_note?
    invoice_request.eu_country?
  end

  private

  attr_accessor :order, :invoice_request

  class Item
    def initialize(order_item)
      self.order_item = order_item
    end

    def name
      "E-book: \"#{order_item.product.display_name}\""
    end

    def net_price
      order_item.price.to_s
    end

    def gross_price
      order_item.price.to_s
    end

    def vat_rate
      VAT_RATE_FOR_BUSINESS_CUSTOMERS
    end

    def vat_amount
      VAT_AMOUNT_FOR_BUSINESS_CUSTOMERS
    end

    private

    attr_accessor :order_item
  end
end
