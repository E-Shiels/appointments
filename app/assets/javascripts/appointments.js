// class Appointment {
//   constructor(id, date, time, description, doctorId, patientId, doctorName, patientName, doctorSlug, patientSlug) {
//     this.id = id;
//     this.date = date;
//     this.time = time;
//     this.description = description;
//     this.doctorId = doctorId;
//     this.patientId = patientId;
//     this.doctorName = doctorName;
//     this.patientName = patientName;
//     this.doctorSlug = doctorSlug;
//     this.patientSlug = patientSlug;
//   }
//   patientUrl() {
//     return `/patients/${this.patientSlug}`;
//   }
//   returnHTML() {
//     return `<div>
//               <table>
//                 <tr><th>Date</th><td>${this.date}</td></tr>
//                 <tr><th>Time</th><td>${this.time}</td></tr>
//                 <tr><th>Patient</th><td><a href='${this.patientUrl()}'>${this.patientName}</a></td></tr>
//               </table>
//               <a href='/appointments/${this.id}' class='show-page-button'>View Full Details</a>
//               <hr>
//             </div>`
//   }
// }

// ATTEMPT AT DYNAMIC CONSTRUCTOR
// function Appointment2(obj) {
//   for (let prop in obj) {
//     console.log(prop)
//     this.prop = obj.prop;
//     console.log(this.prop)
//   }
// }

function Appointment(obj) {
  this.id = obj.id;
  this.date = obj.date;
  this.time = obj.time;
  this.description = obj.description;
  this.doctorId = obj.doctor.id;
  this.patientId = obj.patient.id;
  this.doctorName = obj.doctor.name;
  this.patientName = obj.patient.name;
  this.doctorSlug = obj.doctor.slug;
  this.patientSlug = obj.patient.slug;
}
Appointment.prototype.patientUrl = function() {
  return `/patients/${this.patientSlug}`;
}
Appointment.prototype.returnHTML = function() {
  return `<div>
              <table>
                <tr><th>Date</th><td>${this.date}</td></tr>
                <tr><th>Time</th><td>${this.time}</td></tr>
                <tr><th>Patient</th><td><a href='${this.patientUrl()}'>${this.patientName}</a></td></tr>
              </table>
              <a href='/appointments/${this.id}' class='show-page-button'>View Full Details</a>
              <hr>
            </div>`
}

//Invokes function and sets inverva to run function again
function setIntervalImmediately(func, interval) {
  func();
  return setInterval(func, interval);
}

function getAndAppendAppointments() {
  $.getJSON('/appointments').success(function(data) {
    let i;
    let appointments = [];
    for (i = 0; i < data.length; i++) {
      let a = new Appointment(
        data[i]);
      // data[i].id,
      // data[i].date,
      // data[i].time,
      // data[i].description,
      // data[i].doctor.id,
      // data[i].patient.id,
      // data[i].doctor.name,
      // data[i].patient.name,
      // data[i].doctor.slug,
      // data[i].patient.slug);
      appointments.push(a);
    }
    let o = 0;
    //Empty appointments section and add appointments
    $('#doctor-appointments-section').empty();
    appointments.forEach(function(a) {
      $('#doctor-appointments-section').append(a.returnHTML());
    });
  }).fail(function(jqXHR, textStatus, errorThrown) {
    const errorMessage = 'getJSON request failed! ' + textStatus + ' - ' + errorThrown;
    alert(errorMessage);
    console.log(errorMessage);
  });
}

$(function() {
  $('#quick-create-form').on("submit", function(e) {
    let url = this.action;
    let formData = $(this).serialize();
    $.post(url, formData, function(response) {}).success($('#quick-create-form')[0].reset())
      .then($('#appointments-state-header').html("Today\'s Appointments"))
      .then(getAndAppendAppointments());
    e.preventDefault();
  });
  //Invoke getAndAppendAppointments and set 15 second interval to invoke again
  setIntervalImmediately(function() {
    getAndAppendAppointments();
  }, 15000);
});
