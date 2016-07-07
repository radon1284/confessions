class InvoiceRequestsController < ApplicationController
  def new
    order = Order.find(params.fetch(:order_id))
    invoice_request = order.invoice_requests.build
    render(
      locals: {
        order: order,
        invoice_request: invoice_request
      }
    )
  end

  def create
    order = Order.find(params.fetch(:order_id))
    invoice_request = order.invoice_requests.build(invoice_request_params)
    if invoice_request.save
      redirect_to order_invoice_request_url(order, invoice_request)
    else
      render(:new, locals: { order: order, invoice_request: invoice_request })
    end
  end

  def show
    order = Order.find(params.fetch(:order_id))
    invoice_request = order.invoice_requests.find(params.fetch(:id))
    invoice = Invoice.new(order: order, invoice_request: invoice_request)
    pdf = InvoicePDF.new(invoice)
    send_data(
      pdf.render,
      filename: "invoice-#{order.invoice_number}.pdf",
      type: "application/pdf"
    )
  end

  private

  def invoice_request_params
    params
      .require(:invoice_request)
      .permit(:company_name, :address, :country, :vat_id)
  end
end
