# frozen_string_literal: ture
require "../../rails_helper"

describe Calculation::CalculateTotalsController do
  routes { Calculation::Engine.routes }

  describe "POST create" do
    let(:euro_converter) { instance_double(Calculation::EuroConverter) }
    let(:user_params) do
      {
        user: {
          name: "user",
          email: "user@packhelp.com",
          total_orders_pln: 100
        }
      }
    end

    before do
      expect(Calculation::EuroConverter).to receive(:new).and_return(euro_converter)
    end

    context "when euro converter fails" do
      let(:failed_return_value) { { error: "error", status: :error } }

      before do
        expect(euro_converter).to receive(:call).and_return(failed_return_value)
      end

      it "renders json with the error" do
        post :create, params: user_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]).to eq("error")
      end
    end

    context "when calculation user created without errors" do
      let(:succeed_return_value) { { result: 20, status: :ok } }

      before do
        expect(euro_converter).to receive(:call).and_return(succeed_return_value)
      end

      it "renders json with the error" do
        post :create, params: user_params

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["name"]).to eq(user_params[:user][:name])

        calculation_user = Calculation::User.last

        expect(calculation_user.name).to eq(user_params[:user][:name])
      end
    end
  end
end
