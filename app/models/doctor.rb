class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments

  has_secure_password

  validates :name, presence: true
  validates :gender, presence: true
  validates :age, presence: true,
  validates :age, numericality: true,
  validates :address, presence: true
#  validates :attribute, phone: true
  validates :email, 'valid_email_2/email': { mx: true, disposable: true}
end
