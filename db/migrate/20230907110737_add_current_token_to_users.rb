class AddCurrentTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :is_current_token, :boolean, default: false, index: true
  end
end
