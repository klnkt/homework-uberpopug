# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  enum roles: {
    admin: 'admin',
    manager: 'manager',
    accountant: 'accountant',
    worker: 'worker'
  }

  before_create :generate_uuid

  after_create -> { send_event(:created) }

  private

  def generate_uuid
    self.public_id = SecureRandom.uuid
  end

  def send_event(action)
    event = {
      event_name: "Account#{action.constanize}",
      data: { email:, full_name:, role:, public_id: }
    }

    Producer.call(event.to_json, topic: 'accounts-stream')
  end
end
