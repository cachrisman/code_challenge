class Token < ApplicationRecord
  belongs_to :user

  def self.generate(user)
    @token = Token.new
    @token.user_id = user.id
    @token.nonce = SecureRandom.uuid.gsub(/\-/,'')
    @token.save
    return @token
  end

  def self.consume(nonce)
    @token = Token.find_by_nonce(nonce)
    return nil if @token.nil?
    @user = User.find_by_id(@token.user_id)
    @token.destroy
    return @user
  end

end
