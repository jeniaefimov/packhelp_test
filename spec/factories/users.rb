# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name }
    email { FFaker::Internet.unique.email }
    total_orders_pln { FFaker.numerify('###,##') }
  end
end
