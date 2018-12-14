class Patient < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  # RELATIONSHIPS
  has_many :appointments
  has_many :doctors, through: :appointments

  has_secure_password

  # VALIDATIONS
  validates :name, presence: true
  validates :gender, presence: true

  validates :age, presence: true
  validates :age, numericality: true

  validates :address, presence: true

  validates :phone, presence: true
  validates :phone, numericality: true

  validates :email, presence: true
  validates :email, 'valid_email_2/email': { mx: true, disposable: true}
  validates :email, uniqueness: true

end
