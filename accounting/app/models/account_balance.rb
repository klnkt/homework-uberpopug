class AccountBalance < ApplicationRecord
  belongs_to :account
  has_many :transactions

  scope :positive, -> { where('balance > 0') }
end
