class Account < ApplicationRecord
  has_many :tasks, inverse_of: :account, dependent: :destroy
end
