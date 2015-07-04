class AddAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_id, :string
    add_column :users, :account_key_p, :string
    add_column :users, :account_key_s, :string
  end
end
