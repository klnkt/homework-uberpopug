class Transaction < ApplicationRecord
  belongs_to :account_balance

  after_update :update_balance, if: :saved_change_to_status?

  def task
    ask.find_by(public_id: task_public_id)
  end

  private

  def update_balance
    if status == 'Completed'
      account_balance.update(balance: account_balance.balance + amount)
    end
  end
end
