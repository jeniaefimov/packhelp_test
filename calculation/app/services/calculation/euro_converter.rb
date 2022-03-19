# frozen_string_literal: true
module Calculation
  class EuroConverter
    include HTTParty
    base_uri "http://api.nbp.pl/api"

    FIRST_RATE_HASH = 0

    def initialize(total_in_pln)
      @total_in_pln = total_in_pln
    end

    def call
      options = { query: { format: :json } }
      response = self.class.get("/exchangerates/rates/a/eur/", options)

      calculated_amount = total_in_pln / response["rates"][FIRST_RATE_HASH]["mid"]

      { result: calculated_amount, status: :ok }

    rescue HTTParty::Error => ex
      { error: ex.message, status: :error }
    end

    private

    attr_reader :total_in_pln
  end
end
