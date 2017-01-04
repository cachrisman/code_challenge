class AddIndexToTokensNonce < ActiveRecord::Migration[5.0]
  def change
  	add_index :tokens, :nonce, unique: true
  end
end
