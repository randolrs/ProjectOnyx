class AddNextpaymentToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :next_payment, :datetime
  end
end
