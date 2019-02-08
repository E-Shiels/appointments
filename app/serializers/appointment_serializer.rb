class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :time, :description
  belongs_to :doctor
  belongs_to :patient
end
