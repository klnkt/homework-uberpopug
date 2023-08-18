class Task < ApplicationRecord
  belongs_to :account, foreign_key: 'account_id'

  scope :open, -> { where(status: 'New') }
  scope :completed, -> { where(status: 'Completed') }

  before_create :generate_uuid

  private

  def generate_uuid
    self.public_id = SecureRandom.uuid
  end
end
