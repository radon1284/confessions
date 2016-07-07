class InvoicePDF
  include Prawn::View

  PRODUCT_TABLE_HEADER = [
    "Product",
    "Net price",
    "VAT rate",
    "VAT amount",
    "Gross price"
  ].freeze

  def initialize(invoice)
    self.invoice = invoice
  end

  def render
    setup_fonts
    setup_grid
    draw_content
    super
  end

  private

  attr_accessor :invoice

  def setup_fonts
    font_families.update(
      "Nimbus" => {
        normal: Rails.root.join("private", "fonts", "nimbus-normal.ttf"),
        bold: Rails.root.join("private", "fonts", "nimbus-bold.ttf")
      }
    )
    font "Nimbus"
  end

  def setup_grid
    define_grid(columns: 5, rows: 8, gutter: 10)
  end

  def draw_content
    draw_top_section
    draw_seller_details
    draw_buyer_details
    draw_product_table
    draw_total
    move_down 50
    draw_notes
  end

  def draw_top_section
    grid([0, 0], [0, 1]).bounding_box do
      text "Invoice", size: 18
      text "No: #{invoice.invoice_number}"
      text "Date of issue: #{invoice.date_of_issue.strftime('%F')}"
      text "Payment status: #{invoice.payment_status}"
    end
  end

  def draw_seller_details
    grid([1, 0], [2, 1]).bounding_box do
      text "Seller:", style: :bold
      text invoice.seller_name
      text invoice.seller_address
      text invoice.seller_country
      text invoice.seller_vat_id
    end
  end

  def draw_buyer_details
    grid([1, 3], [2, 4]).bounding_box do
      text "Buyer:", style: :bold
      text invoice.buyer_name
      text invoice.buyer_address
      text invoice.buyer_country
      draw_buyer_vat_id
    end
  end

  def draw_buyer_vat_id
    text "VAT ID: #{invoice.buyer_vat_id}" if invoice.display_buyer_vat_id?
  end

  def draw_product_table
    items = invoice.items.map do |item|
      [
        item.name,
        item.net_price,
        item.vat_rate,
        item.vat_amount,
        item.gross_price
      ]
    end

    table([PRODUCT_TABLE_HEADER] + items)
  end

  def draw_total
    table(
      [["Total:", invoice.total]],
      column_widths: [100, 100],
      cell_style: { font_style: :bold }
    )
  end

  def draw_notes
    return unless invoice.reverse_charge_note?

    text "Notes:"
    text "reverse charge"
  end
end
