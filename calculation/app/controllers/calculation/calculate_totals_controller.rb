# frozen_string_literal: true
module Calculation
  class CalculateTotalsController < ApplicationController
    def create
      return_value = Calculation::EuroConverter.new(params[:total_orders_pln]).call

      if return_value[:status] == :error
        render json: { error: return_value[:error] }, status: :unprocessable_entity
        return
      end

      calculation_user = Calculation::User.create(
        total_orders_eur: return_value[:result],
        email: calculate_totals_params[:email],
        name: calculate_totals_params[:name],
        total_orders_pln: calculate_totals_params[:total_orders_pln])

      if calculation_user.errors.any?
        render json: { error: calculation_user.errors.full_message }, status: :unprocessable_entity
      else
        render json: calculation_user, status: :ok
      end
    end

    def calculate_totals_params
      params.require(:user).permit(:name, :email, :total_orders_pln)
    end
  end
end
