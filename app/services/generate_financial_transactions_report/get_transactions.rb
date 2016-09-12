class GenerateFinancialTransactionsReport
  class GetTransactions
    class UnknownTransactionTypeError < StandardError; end

    KNOWN_TRANSACTION_TYPES = %w(charge refund transfer).freeze

    def self.build
      new(DI.get(FetchFromStripe))
    end

    def initialize(fetch_from_stripe)
      self.fetch_from_stripe = fetch_from_stripe
    end

    def call(date)
      fetch_from_stripe.call(date, date.end_of_month).map do |raw_transaction|
        check_type(raw_transaction.type)

        Transaction.new(
          raw_transaction.type,
          raw_transaction.amount,
          Time.zone.at(raw_transaction.created),
          get_order_id(raw_transaction),
          raw_transaction.fee
        )
      end
    end

    private

    attr_accessor :fetch_from_stripe

    def check_type(type)
      raise(
        UnknownTransactionTypeError,
        "#{type} is not supported"
      ) unless KNOWN_TRANSACTION_TYPES.include?(type)
    end

    def get_order_id(raw_transaction)
      case raw_transaction.type
      when "charge"
        raw_transaction.source.metadata.order_id
      when "refund"
        raw_transaction.source.charge.metadata.order_id
      else
        nil
      end
    end
  end
end
