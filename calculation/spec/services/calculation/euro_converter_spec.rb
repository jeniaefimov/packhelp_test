# frozen_string_literal: ture
require "rails_helper"

describe Calculation::EuroConverter do
  subject { described_class.new(amount) }

  let(:amount) { 100 }

  describe "#call" do
    before do
      expect(described_class).to receive(:get).and_return(response)
    end

    context "when correctly get info from NBP endpoint" do
      let(:rate) { 5 }
      let(:response) { { "rates" => [{ "mid" => rate }] } }

      it "correctly calculates amount in euros" do
        return_value = subject.call

        expect(return_value[:result]).to eq(amount / rate)
        expect(return_value[:errors]).to be_nil
      end
    end
  end
end
