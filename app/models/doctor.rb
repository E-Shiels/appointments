class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments

  has_secure_password

  validates :name, presence: true
  validates :gender, presence: true
  validates :specialty, presence: true
  validates :practice_name, presence: true
  validates :practice_location, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :email, 'valid_email_2/email': { mx: true, disposable: true}
  validates :email, uniqueness: true
end
