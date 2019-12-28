class AddEmailDomToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :email, :string
    add_column :shops, :domain, :string
    add_column :shops, :slug, :string
    add_column :shops, :subscribed, :boolean, default: true
  end
end
