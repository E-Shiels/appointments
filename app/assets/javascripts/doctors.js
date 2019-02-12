class Doctor {
  constructor(name, gender, speciality, practice_name, practice_location, phone, email) {
    this.name = name;
    this.gender = gender;
    this.speciality = speciality;
    this.practice_name = practice_name;
    this.practice_location = practice_location;
    this.phone = phone;
    this.email = email;
  }
}

$(function() {
  $.getJSON('/doctors.json').success(function(data) {
    let i;
    let appointments = [];

    for (i = 0; i < data.length; i++) {
      let a = new Appointment(
        data[i].id,
        data[i].date,
        data[i].time,
        data[i].description,
        data[i].doctor_id,
        data[i].patient_id,
        data[i].doctor.name,
        data[i].patient.name,
        data[i].doctor.slug,
        data[i].patient.slug);
      appointments.push(a);
    }
  });
  });
})
