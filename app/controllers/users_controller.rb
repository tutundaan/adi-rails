class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :generate]
  before_action :set_user_from_token, only: [:create]

  def create
    if User.valid_token? params[:token] and @user.active_token? params[:token]
      @new_user = User.new(user_params)
      if @new_user.save
        # TODO : send email to user
        render :show, status: :ok, location: @new_user
      else
        render json: { message: @new_user.errors, code: :unprocessable_entity }, status: :unprocessable_entity
      end
    else
      render :show, status: :non_authoritative_information
    end
  end

  def generate
    if @user and @user.authenticate params[:user][:password]
      generate_token
    else
      render status: :non_authoritative_information
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    def set_user
      require_user_params
      @user = User.find_by_email params[:user][:email]
    end

    def require_user_params
      params.require(:user).permit(:email, :password)
    end

    def generate_token
      @token = @user.generate_token params[:user][:password]
    end

    def set_user_from_token
      @user = User.find_by_token params[:token]
    end
end
