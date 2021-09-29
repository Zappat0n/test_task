class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to jobs_path
    else
      redirect_to login_path, alert: @user ? 'Wrong password' : 'Wrong user'
    end
  end

  def destroy
    session[:user_id] = nil
    current_user = nil
    redirect_to root_path, notice: 'You have logged out'
  end
end
