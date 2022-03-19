# frozen_string_literal: true
module Calculation
  class CalculateTotalsSecondVersionController < ApplicationController
    def create
      main_app_user_helper = MainApp::CalculationApi::UserHelper.new(params[:main_app_user_id])
      main_app_user = main_app_user_helper.user

      return_value = Calculation::EuroConverter.new(main_app_user.total_orders_pln).call

      if return_value[:status] == :error
        render json: { error: return_value[:error] }, status: :unprocessable_entity
        return
      end

      ActiveRecord::Base.transaction do
        main_app_user_helper.update_user(total_orders_eur: return_value[:result])
        Calculation::User.create(main_app_user.attributes.slice(:id))
      end

      render json: main_app_user, status: :ok

    rescue ActiveRecord::RecordInvalid => exception
      render json: { error: "#{exception.record.class.to_s} - #{exception.message}" }, status: :unprocessable_entity
    end
  end
end
