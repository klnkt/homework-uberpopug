class Task < ApplicationRecord
  belongs_to :account

  before_create :generate_uuid

  private

  def generate_uuid
    self.public_id = SecureRandom.uuid
  end
end
