class GenerateFinancialTransactionsReport
  class FetchBalanceTransactions
    def self.build
      new
    end

    def call(start_date, end_date)
      fetch({ gte: start_date.to_i, lte: end_date.to_i }, nil)
    end

    private

    def fetch(created, starting_after)
      current_items = Stripe::BalanceTransaction.all(
        created: created,
        limit: 100,
        starting_after: starting_after,
        expand: ["data.source.charge"]
      ).to_a

      if current_items.present?
        current_items + fetch(created, current_items.last.id)
      else
        []
      end
    end
  end
end
