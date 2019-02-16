class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :age, :address, :phone, :email, :slug
  has_many :doctors, serializer: PatientDoctorSerializer
end
