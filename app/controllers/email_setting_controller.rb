class EmailSettingController < ApplicationController

  def index
  end

  # POST /email_setting
  def submit
    email = params[:email]
    @user = User.find_by_email(email)
    nonce = params[:nonce]
    @user_by_nonce = Token.consume(nonce)

    return redirect_to root_path, alert: "invalid email" if @user.nil?
    return redirect_to root_path, alert: "invalid nonce" if @user_by_nonce.nil?
    return redirect_to root_path, alert: "user/nonce mismatch" if not @user.eql? @user_by_nonce

    params[:receive_marketing] = false if params[:receive_marketing].nil?
    params[:receive_articles] = false if params[:receive_articles].nil?
    params[:receive_digest] = false if params[:receive_digest].nil?

    if @user.update(email_setting_params)
      token = Token.generate(@user)
      redirect_to root_path, notice: "User was successfully updated.Use #{token.nonce} for next update"
    else
      redirect_to root_path, alert: "error"
    end
  end

  private
    def email_setting_params
      params.permit(:email, :receive_marketing, :receive_articles, :receive_digest)
    end
end
