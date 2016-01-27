class AddAccesscodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_code, :string, default: ""
  end
end
