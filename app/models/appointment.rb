class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates_date :date
end
