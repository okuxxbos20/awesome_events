class SessionsController < ApplicationController
  # createメソッドだけauthenticateをスキップできる。
  # なのでloginhしていなくてもcreateメソッドは使える
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: 'Successfully Logined!'
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You Are Logged Out...'
  end
end
