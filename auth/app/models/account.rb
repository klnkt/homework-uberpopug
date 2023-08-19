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

  enum role: {
    admin: 'admin',
    accounting_clerk: 'accounting_clerk',
    repairman: 'repairman',
    employee: 'employee'
  }

  before_create :generate_public_id

  after_create do
    account = self

    # ----------------------------- produce event -----------------------
    event = {
      event_name: 'AccountCreated',
      data: {
        public_id: account.public_id,
        email: account.email,
        full_name: account.full_name,
        position: account.position
      }
    }

    Karafka.producer.produce_sync(payload: event.to_json, topic: 'accounts-stream')
    # --------------------------------------------------------------------
  end

  private

  def generate_public_id
    self.public_id = SecureRandom.uuid
  end
end
