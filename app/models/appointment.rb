class Appointment < ApplicationRecord

  # RELATIONSHIPS
  belongs_to :doctor
  belongs_to :patient

  # SCOPE METHODS
  scope :today, -> {where(date: Date.today)}
  scope :this_week, -> {where("date >= ? AND date <= ?", Date.today, Date.today+1.week )}

  # VALIDATIONS
  validates :doctor_id, presence: true
  validates :doctor_id, numericality: true

  validates :patient_id, presence: true
  validates :patient_id, numericality: true

  validates :date, presence: true
  validates :time, presence: true

end
