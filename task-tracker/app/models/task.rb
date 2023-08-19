class Task < ApplicationRecord
  belongs_to :account, foreign_key: 'account_id'

  scope :open, -> { where(status: 'New') }
  scope :completed, -> { where(status: 'Completed') }

  validate :jira_id_not_in_title

  before_create :generate_uuid

  private

  def generate_uuid
    self.public_id = SecureRandom.uuid
  end

  def jira_id_not_in_title
    return unless title.match?(/\[.*\]/)

    errors.add(:title, 'cannot contain JIRA ID')
  end
end
