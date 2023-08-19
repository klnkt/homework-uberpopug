class Account < ApplicationRecord
  has_one :account_balance
  has_many :transactions, through: :account_balance
end
