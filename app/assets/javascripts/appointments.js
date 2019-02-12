class Appointment {
  constructor(date, time, description, doctor_id, patient_id) {
    this.date = date;
    this.time = time;
    this.description = description;
    this.doctor_id = doctor_id;
    this.patient_id = patient_id;
  }
}

$(function() {
  $.getJSON('/appointments.json').success(function(data) {
    let i;
    let appointments = [];

    for (i = 0; i < data.today.length; i++) {
      let a = new Appointment(data.today[i].date,
        data.today[i].time,
        data.today[i].description,
        data.today[i].doctor_id,
        data.today[i].patient_id);
      appointments.push(a);
    }

    appointments.forEach(function(a) {
      $('.doctor-appointment-date').html(`${a.date}`);
      $('.doctor-appointment-time').html(`${a.time}`);
        debugger
    });
  });
});
