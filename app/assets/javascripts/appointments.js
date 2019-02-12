class Appointment {
  constructor(date, time, description, doctor_id, patient_id, doctor_name, patient_name, doctor_slug, patient_slug) {
    this.date = date;
    this.time = time;
    this.description = description;
    this.doctor_id = doctor_id;
    this.patient_id = patient_id;
    this.doctor_name = doctor_name;
    this.patient_name = patient_name;
    this.doctor_slug = doctor_slug;
    this.patient_slug = patient_slug;
  }
}

$(function() {
  $.getJSON('/appointments.json').success(function(data) {
    let i;
    let appointments = [];

    for (i = 0; i < data.length; i++) {
      let a = new Appointment(data[i].date,
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

    appointments.forEach(function(a) {
      $('.doctor-appointment-date').html(`${a.date}`);
      $('.doctor-appointment-time').html(`${a.time}`);
      $('.doctor-appointment-patient').html(`<a href='/patients/${a.patient_slug}'>${a.patient_name}</a>`);
      $('.doctor-appointment-description').html(`${a.description}`);
    });
  });
});
