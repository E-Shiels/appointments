class PatientDoctorSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :specialty
end
