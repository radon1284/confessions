class GenerateFinancialTransactionsReport
  Transaction = Struct.new(:type, :amount, :date, :order_id, :fee_amount)
end
