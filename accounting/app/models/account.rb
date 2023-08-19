class Account < ApplicationRecord
  has_many :tasks, foreign_key: 'account_id', dependent: :destroy
end
