class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :time, :description
  belongs_to :doctor, serializer: AppointmentDoctorSerializer
  belongs_to :patient, serializer: AppointmentPatientSerializer
end
