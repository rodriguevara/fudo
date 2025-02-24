module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_request, only: [:login]

      def login
        user = User.find_by(email: login_params[:email])
        if user&.authenticate(login_params[:password])
          token = jwt_encode(user_id: user.id)
          render json: { token: token }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
