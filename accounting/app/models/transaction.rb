class Transaction < ApplicationRecord
  belongs_to :account_balance

  def task
    ask.find_by(public_id: task_public_id)
  end
end
