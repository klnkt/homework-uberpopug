class Account < ApplicationRecord
  has_many :tasks, foreign_key: 'account_id', dependent: :destroy

  scope :employees, -> { where(role: 'employee') }
  scope :with_negative_balance, -> { where('balance < 0') }
end
