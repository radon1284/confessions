class CustomerSupportRequestsController < ApplicationController
  def new
    customer_support_request = CustomerSupportRequest.new
    render(
      locals: {
        customer_support_request: customer_support_request
      }
    )
  end

  def create
    customer_support_request = CustomerSupportRequest.new(
      customer_support_request_params
    )

    if customer_support_request.save
      notify_customer_support(customer_support_request)
      redirect_to root_url, notice: "You message has been sent."
    else
      handle_error(customer_support_request)
    end
  end

  private

  def customer_support_request_params
    params.require(:customer_support_request).permit(:subject, :body, :email)
  end

  def handle_error(customer_support_request)
    render(
      :new,
      locals: {
        customer_support_request: customer_support_request
      }
    )
  end

  def notify_customer_support(customer_support_request)
    CustomerSupportNotificationWorker.perform_async(
      customer_support_request.id
    )
  end
end
