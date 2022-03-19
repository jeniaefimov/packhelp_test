# frozen_string_literal: true
module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: PaginationWrapper
                       .new(User.all, UserSerializer)
                       .page(params[:page])
                       .per(params[:per_page])
                       .result
                       .to_json, status: :ok
      end

      def create
        total_orders_pln = ::OrderAmountGenerator.new.call
        total_orders_eur = ::Calculation::EuroConverter.new(total_orders_pln).call

        user = User.create(name: user_params[:name], email: user_params[:email],
                           total_orders_pln: total_orders_pln,
                           total_orders_eur: total_orders_eur)

        if user.errors.any?
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        else
          render json: user, serializer: UserSerializer, status: :ok
        end
      end

      def show
        user = User.find(params[:id])

        render json: user, serializer: UserSerializer, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name, :email)
      end
    end
  end
end
