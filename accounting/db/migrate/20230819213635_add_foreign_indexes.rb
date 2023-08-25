class AddForeignIndexes < ActiveRecord::Migration[7.0]
  def change
    # add foreign key for accounts and account balance
    add_foreign_key :account_balances, :accounts, column: :account_id, primary_key: :id
    add_foreign_key :transactions, :account_balances, column: :account_balance_id, primary_key: :id
  end
end
