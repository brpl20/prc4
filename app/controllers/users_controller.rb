class UsersController < ApplicationController
  before_action :authenticate_user!


  private

  # Only allow a list of trusted parameters through.
  # def user_params
  #   params.require(:user).permit(
  #     :email,
  #     :lawyer_role,
  #     :paralegal_role,
  #     :intern_role
  #   )
  # end
end
