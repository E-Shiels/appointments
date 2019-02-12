class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :time
  belongs_to :patient, serializer: AppointmentPatientSerializer
  belongs_to :doctor, serializer: AppointmentDoctorSerializer
end
