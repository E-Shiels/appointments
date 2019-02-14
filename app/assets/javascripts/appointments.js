class Appointment {
  constructor(r_id, date, time, description, doctor_id, patient_id, doctor_name, patient_name, doctor_slug, patient_slug) {
    this.r_id = r_id;
    this.date = date;
    this.time = time;
    this.description = description;
    this.doctor_id = doctor_id;
    this.patient_id = patient_id;
    // Considered instantiating classes for these objects, but I feel that this is easier for now
    this.doctor_name = doctor_name;
    this.patient_name = patient_name;
    this.doctor_slug = doctor_slug;
    this.patient_slug = patient_slug;
  }
  patient_url() {
    return `/patients/${this.patient_slug}`;
  }
}

$(function() {
  $.getJSON('/appointments.json').success(function(data) {
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
    let o = 0;
    appointments.forEach(function(a) {
      $('#doctor-appointments-section').append(`<div id='div-${o}'></div>`);
      $(`#div-${o}`).append(`<table id='table-${o}'></table>`);
      $(`#table-${o}`).append(`<tr><th>Date</th><td>${a.date}</td></tr>`);
      $(`#table-${o}`).append(`<tr><th>Time</th><td>${a.time}</td></tr>`);
      $(`#table-${o}`).append(`<tr><th>Patient</th><td><a href='${a.patient_url()}'>${a.patient_name}</a></td></tr>`);
      $(`#table-${o}`).append(`<tr><th>Description</th><td>${a.description}</td></tr>`);
      $(`#div-${o}`).append(`<a href='/appointments/${a.r_id}' class='show-page-button'>View Full Details</a>`);
      $(`#div-${o}`).append('<hr>');
      o++;
    });
  });
});
