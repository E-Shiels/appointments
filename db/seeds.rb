#PATIENTS
Patient.create(name: "Carlos Ramos", gender: "M", age: "20", address: "123 Street Avenue, Cityville", phone: "9058232323", email: "test@test.com", password: "test")
Patient.create(name: "Jane Doe", gender: "F", age: "30", address: "456 Parkway Road, Village", phone: "4166100629", email: "me@test.ca", password: "12345")
Patient.create(name: "Mike Smith", gender: "M", age: "40", address: "789 Boulevard Crescent, Town", phone: "6475858554", email: "juliojonesisthebest@email.com", password: "password")
Patient.create(name: "Mary Barry", gender: "F", age: "70", address: "012 Alley Court, Metropolis", phone: "9051111010", email: "mary@gmail.com", password: "betterpassword")

#DOCTORS
Doctor.create(name: "Harry Jones", gender: "M", specialty: "GP", practice_name: "Harry's Office", practice_location: "345 Lane Street", phone: "", email: "magician@doctors.com", password: "123456789")
Doctor.create(name: "Frederick Murphy", gender: "M", specialty: "Cardiology", practice_name: "Jones and Co.", practice_location: "567 Doctors Drive", phone: "9564454445", email: "doc@doctors.com", password: "abcd")
Doctor.create(name: "Julia Rondeau", gender: "F", specialty: "Epidemiology", practice_name: "The Hospital of Medicine", practice_location: "890 Medical Promenade", phone: "9442323156", email: "tester@emails.com", password: "secret")
Doctor.create(name: "Michelle Roper", gender: "F", specialty: "Cardiothoracic Surgery", practice_name: "Beating Heart Medicine", practice_location: "123 Heart Road", phone: "8677675933", email: "michelle@michelleroper.com", password: "wordsgohere")

#APPOINTMENTS
Appointment.create(doctor_id: 1, patient_id: 2, description: "test 1", date: "2018-12-14", time: "12:09 AM")
Appointment.create(doctor_id: 2, patient_id: 3, description: "test 2", date: "2019-01-15", time: "2:09 PM")
Appointment.create(doctor_id: 3, patient_id: 4, description: "test 3", date: "2019-02-16", time: "2:09 AM")
Appointment.create(doctor_id: 4, patient_id: 1, description: "test 4", date: "2019-03-17", time: "12:09 PM")
