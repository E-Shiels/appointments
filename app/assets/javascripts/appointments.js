class Appointment {
  constructor(id, date, time, description, doctorId, patientId, doctorName, patientName, doctorSlug, patientSlug) {
    this.id = id;
    this.date = date;
    this.time = time;
    this.description = description;
    this.doctorId = doctorId;
    this.patientId = patientId;
    this.doctorName = doctorName;
    this.patientName = patientName;
    this.doctorSlug = doctorSlug;
    this.patientSlug = patientSlug;
  }
  patientUrl() {
    return `/patients/${this.patientSlug}`;
  }
}

function setIntervalImmediately(func, interval) {
  func();
  return setInterval(func, interval);
}

function getAndAppendAppointments() {
  $.getJSON('/appointments.json').success(function(data) {
    let i;
    let appointments = [];
    for (i = 0; i < data.length; i++) {
      let a = new Appointment(
        data[i].id,
        data[i].date,
        data[i].time,
        data[i].description,
        data[i].doctor.id,
        data[i].patient.id,
        data[i].doctor.name,
        data[i].patient.name,
        data[i].doctor.slug,
        data[i].patient.slug);
      appointments.push(a);
    }
    let o = 0;
    $('#doctor-appointments-section').empty();
    appointments.forEach(function(a) {
      $('#doctor-appointments-section').append(`<div id='div-${o}'></div>`);
      const $div = $(`#div-${o}`);
      $div.append(`<table id='table-${o}'></table>`);
      const $table = $(`#table-${o}`);
      $table.append(`<tr><th>Date</th><td>${a.date}</td></tr>`);
      $table.append(`<tr><th>Time</th><td>${a.time}</td></tr>`);
      $table.append(`<tr><th>Patient</th><td><a href='${a.patientUrl()}'>${a.patientName}</a></td></tr>`);
      $div.append(`<a href='/appointments/${a.id}' class='show-page-button'>View Full Details</a>`);
      $div.append('<hr>');
      o++;
    });
  }).fail(function(jqXHR, textStatus, errorThrown) {
    const errorMessage = 'getJSON request failed! ' + textStatus + ' - ' + errorThrown;
    alert(errorMessage);
    console.log(errorMessage);
  });
}

$(function() {
  setIntervalImmediately(function() {
    getAndAppendAppointments();
  }, 15000);
});

$(function() {
  $('#quick-create-form').on("submit", function(e) {
    let url = this.action;
    let formData = $(this).serialize();
    $.post(url, formData, function(response) {}).success($('#quick-create-form')[0].reset())
      .then($('#appointments-state-header').html("Today\'s Appointments"))
      .then(getAndAppendAppointments());
    e.preventDefault();
  });
});
