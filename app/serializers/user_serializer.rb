# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :total_orders_pln, :total_orders_eur
end
