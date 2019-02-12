class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :specialty, :practice_name, :practice_location, :phone, :email, :slug
end
