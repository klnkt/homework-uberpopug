class CreateAccountBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :account_balances do |t|
      t.float :balance

      t.timestamps
    end
  end
end
