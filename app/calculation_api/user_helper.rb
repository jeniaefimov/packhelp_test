# frozen_string_literal: true
module CalculationApi
  class UserHelper
    attr_reader :user

    def initialize(user_id)
      @user = User.find(user_id)
    end

    def update_user(attributes)
      user.update(attributes)
    end
  end
end
