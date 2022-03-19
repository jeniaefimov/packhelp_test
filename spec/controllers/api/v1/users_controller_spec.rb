# frozen_string_literal: ture
require "rails_helper"

describe Api::V1::UsersController do
  describe "GET index" do
    let(:first_user) { create(:user) }
    let(:second_user) { create(:user) }

    before do
      first_user
      second_user
    end

    context "when page param is passed" do
      it "renders paginated amount of user records" do
        get :index, params: { page: 1, per_page: 1 }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["records"].count).to eq(1)
      end
    end

    context "when page param is not passed" do
      it "renders all user records" do
        get :index

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["records"].count).to eq(2)
      end
    end
  end

  describe "POST create" do
    let(:user_params) do
      {
        name: "new user",
        email: "email@packhelp.com"
      }
    end

    context "when user created successfully" do
      let(:calculation_euro_converter) { instance_double(Calculation::EuroConverter) }
      let(:order_amount_generator) { instance_double(OrderAmountGenerator) }
      let(:generated_amount) { 145.44 }
      let(:amount_in_eur) { 30 }

      before do
        expect(Calculation::EuroConverter).to receive(:new).and_return(calculation_euro_converter)
        expect(calculation_euro_converter).to receive(:call).and_return(amount_in_eur)
        expect(OrderAmountGenerator).to receive(:new).and_return(order_amount_generator)
        expect(order_amount_generator).to receive(:call).and_return(generated_amount)
      end

      it "returns correctly serialized record" do
        post :create, params: { user: user_params }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["name"]).to eq(user_params[:name])
        expect(JSON.parse(response.body)["email"]).to eq(user_params[:email])
        expect(JSON.parse(response.body)["errors"]).to be_nil

        expect(User.count).to eq(1)

        user = User.last

        expect(user.name).to eq(user_params[:name])
        expect(user.email).to eq(user_params[:email])
        expect(user.total_orders_pln).to eq(generated_amount)
        expect(user.total_orders_eur).to eq(amount_in_eur)
      end
    end

    context "when user creation failed" do
      let(:existing_user) { create(:user, email: "email@packhelp.com") }

      before do
        existing_user
      end

      it "returns correct errors" do
        post :create, params: { user: user_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to eq(["Email has already been taken"])

        expect(User.count).to eq(1)
      end
    end
  end

  describe "GET show" do
    let(:existing_user) { create(:user) }

    before do
      existing_user
    end

    it "returns specific user record serialized" do
      get :show, params: { id: existing_user.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq(existing_user.name)
      expect(JSON.parse(response.body)["email"]).to eq(existing_user.email)
    end
  end
end
