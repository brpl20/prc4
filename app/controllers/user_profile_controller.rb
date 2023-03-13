class UserProfileController < UsersController
  layout "backoffice"
  before_action :verify_password, only: [:update]
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.includes(:user_profile).all
  end

  def new
    @user = User.new
    @user.build_user_profile
    @user.build_bank
  end

  def save; end

  def create
    up = params_user
    up[:user_profile_attributes][:gender] = up[:user_profile_attributes][:gender].to_i
    up[:user_profile_attributes][:status] = up[:user_profile_attributes][:status].to_i
    @user = User.new(up)
    if @user.save
      redirect_to profile_index_path
    else
      render :new
    end
  end

  def edit
    @user.build_user_profile if @user.user_profile.blank?
  end

  def update
    if @user.update(params_user)
      bypass_sign_in(@user) if @user.email == current_user.email
      redirect_to profile_index_path, notice: 'Usuário Atualizado com sucesso!'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to profile_index_path, notice: "O usuário foi excluído com sucesso"
    else
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def verify_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end

  def params_user
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      user_profile_attributes: %i[id role name lastname gender general_register oab
                                  social_number citizenship civilstatus birth mothername
                                  email address city state phone zip status origin office_id],
      bank_attributes: %i[id name agency account]
    )
  end
end
