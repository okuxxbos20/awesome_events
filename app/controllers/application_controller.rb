class ApplicationController < ActionController::Base
  # 全てのコントローラの全てのアクションは、それの実行前にauthenticateが実行される
  before_action :authenticate
  # 全てのコントローラではlogged_in?メソッドとcurrent_userメソッドが使える
  helper_method :logged_in?, :current_user

  private

  # session＿idをチェックし、login状態かどうかを返す
  def logged_in?
    !!session[:user_id]
  end

  # session_idがあれば、それを使って現在のuser情報を取得してくる
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  # login情報かそうかをチェックし、loginしていなければアラートを出してindexにリダイレクト
  def authenticate
    return if logged_in?
    redirect_to root_path, alert: "ログインしてください"
  end
end
