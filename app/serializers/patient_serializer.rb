class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :age, :address, :phone, :email, :slug
  has_many :doctor, serializer: PatientDoctorSerializer
end
