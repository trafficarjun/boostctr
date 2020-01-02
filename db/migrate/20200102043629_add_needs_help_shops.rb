class AddNeedsHelpShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :needs_help, :boolean, default: true
  end
end
