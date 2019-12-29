class AddGoogleToken < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :google_token, :string
    add_column :shops, :google_refresh_token, :string
    add_column :shops, :google_email, :string
    add_column :shops, :expiresat, :datetime
  end
end