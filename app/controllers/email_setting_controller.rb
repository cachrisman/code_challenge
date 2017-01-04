class EmailSettingController < ApplicationController

  def index
    email = params[:email]
    token = params[:token]
    if not email.nil? and not token.nil?
      user_by_email = User.find_by_email(email)
      token_by_nonce = Token.find_by_nonce(token)
      user_by_token = token_by_nonce.present? ? User.find(Token.find_by_nonce(token).user_id) : nil
      if user_by_email.present? and user_by_token.present? and user_by_email.eql? user_by_token
        @email = email
        @token = token
        @receive_marketing = user_by_email.receive_marketing
        @receive_articles = user_by_email.receive_articles
        @receive_digest = user_by_email.receive_digest
      end
    end
  end

  # POST /email_setting
  def submit
    email = params[:email]
    @user = User.find_by_email(email)
    token = params[:token]
    @user_by_token = Token.consume(token)

    return redirect_to '/email_setting', alert: "invalid email" if @user.nil?
    return redirect_to '/email_setting', alert: "invalid token" if @user_by_token.nil?
    return redirect_to '/email_setting', alert: "user/token mismatch" if not @user.eql? @user_by_token

    if @user.update(email_setting_params)
      token = Token.generate(@user)
      redirect_to '/email_setting', notice: "User was successfully updated.Use #{token.nonce} for next update"
    else
      redirect_to '/email_setting', alert: "error"
    end
  end

  private
    def email_setting_params
      params.permit(:email, :receive_marketing, :receive_articles, :receive_digest)
    end
end
