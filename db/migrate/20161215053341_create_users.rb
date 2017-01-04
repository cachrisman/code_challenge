class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :receive_marketing
      t.boolean :receive_articles
      t.boolean :receive_digest

      t.timestamps
    end
  end
end
