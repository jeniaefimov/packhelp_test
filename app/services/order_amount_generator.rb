# frozen_string_literal: true
class OrderAmountGenerator
  RANGE_START_NUMBER = 100.00
  RANGE_END_NUMBER = 200.00

  def call
    rand(RANGE_START_NUMBER..RANGE_END_NUMBER)
  end
end
