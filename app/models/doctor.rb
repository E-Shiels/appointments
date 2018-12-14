class Doctor < ApplicationRecord
  #FRIENDLY ID
  extend FriendlyId
  friendly_id :name, use: :slugged

  # RELATIONSHIPS
  has_many :appointments
  has_many :patients, through: :appointments

  # VALIDATIONS
  validates :name, presence: true

  validates :email, presence: true
  validates :email, 'valid_email_2/email': { mx: true, disposable: true}
  validates :email, uniqueness: true

  has_secure_password

  #CLASS METHODS
  def self.login_with_omniauth(auth)
    find_from_omniauth(auth) || create_with_omniauth(auth)
  end

  def self.find_from_omniauth(auth)
    find_by(email: auth.extra.all_emails[0].email)
  end

  def self.create_with_omniauth(auth)
    create(:email => auth.extra.all_emails[0].email,
      :name => auth.info.name,
      :password => SecureRandom.hex(10))
  end

end
