class Appointment {
  constructor(date, time, description, doctor_id, patient_id) {
    this.date = date
    this.time = time
    this.description = description
    this.doctor_id = doctor_id
    this.patient_id = patient_id
  }
}

$(function() {
  $('#doctor-appointments-section').append('BYE')
});
