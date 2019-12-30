class ChangeDefaultFalse < ActiveRecord::Migration[6.0]
  def change
    remove_column :tests, :four_week_before_updated
    remove_column :tests, :one_week_after_updated
    remove_column :tests, :two_week_after_updated
    remove_column :tests, :four_week_after_updated
    add_column :tests, :four_week_before_updated, :boolean, default: false
    add_column :tests, :one_week_after_updated, :boolean, default: false
    add_column :tests, :two_week_after_updated, :boolean, default: false
    add_column :tests, :four_week_after_updated, :boolean, default: false
  end
end
