class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

scope :today, -> {where(date: Date.today)}
scope :this_week, -> {where("date >= ? AND date <= ?", Date.today, Date.today+1.week )}

  #validates_date :date
  validates :doctor_id, presence: true
  validates :patient_id, presence: true
  validates :date, presence: true
  validates :time, presence: true

end
