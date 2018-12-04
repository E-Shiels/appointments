class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

scope :today, lambda {|date| {:conditions => ['date >= ? AND date <= ?', date.beginning_of_day, date.end_of_day]}}
  #validates_date :date
end
