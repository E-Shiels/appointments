//ES5 Object Constructor
function Doctor(obj) {
  this.id = obj.id;
  this.name = obj.name;
  this.gender = obj.gender;
  this.specialty = obj.specialty;
  this.practiceName = obj.practiceName;
  this.practiceLocation = obj.practiceLocation;
  this.phone = obj.phone;
  this.email = obj.email;
  this.slug = obj.slug;
}

let doctors = [];
let idList = [];

$(function() {
  $.getJSON('/doctors.json').success(function(data) {
    //Instantiate doctors
    let i;
    for (i = 0; i < data.length; i++) {
      let d = new Doctor(
        data[i]);
      doctors.push(d);
    }
    doctors.map(doctor => idList.push(doctor.id));
  }).fail(function(jqXHR, textStatus, errorThrown) {
    const errorMessage = 'getJSON request failed! ' + textStatus + ' - ' + errorThrown;
    alert(errorMessage);
    console.log(errorMessage);
  });

  $('#view-appointments-button').on('click', function() {
    const url = `${window.location.pathname}.json`;
    $.get(url, function(res) {
      let appointments = [];
      res.forEach(function(a) {
        let newA = new Appointment(a);
        appointments.push(newA);
      });
      // appointments.sort(function(a, b) {
      //   return Date.parse(`${a.date}, ${a.time}`) - Date.parse(`${b.date}, ${b.time}`);
      // });
      appointments.sort(function(a, b) {
        var nameA = a.patientName.toUpperCase(); // ignore upper and lowercase
        var nameB = b.patientName.toUpperCase(); // ignore upper and lowercase
        if (nameA < nameB) {
          return -1;
        }
        if (nameA > nameB) {
          return 1;
        }
        // names must be equal
        return 0;
      })
      appointments.forEach(function(a) {
        $('#new-appointments-section').append(a.returnHTML());
      });
    });
  });
});

function nextDoctor() {
  let currentId = $('table').data('id');
  let currentDoctor = doctors.find(function(doctor) {
    return doctor.id === currentId;
  });
  let lastDoctor = doctors[doctors.length - 1];
  let nextId;
  let nextDoctor;

  function useNextDoctorHTML() {
    $('#doctor-name').html(`${nextDoctor.name}`);
    $('#doctor-gender').html(`${nextDoctor.gender}`);
    $('#doctor-specialty').html(`${nextDoctor.specialty}`);
    $('#doctor-practice_name').html(`${nextDoctor.practiceName}`);
    $('#doctor-practice_location').html(`${nextDoctor.practiceLocation}`);
    $('#doctor-phone').html(`${nextDoctor.phone}`);
    $('#doctor-email').html(`${nextDoctor.email}`);
    $('table').data('id', nextId);
  }

  switch (currentDoctor) {
    default:
      nextId = idList[idList.indexOf(currentId) + 1];
      nextDoctor = doctors.find(function(element) {
        return element.id === nextId;
      });
      useNextDoctorHTML();
      window.history.pushState(nextDoctor, `${nextDoctor.name}`, `/doctors/${nextDoctor.slug}`);
      currentDoctor = nextDoctor;
      break;

    case lastDoctor:
      nextId = idList[0];
      nextDoctor = doctors.find(function(element) {
        return element.id === nextId;
      });
      useNextDoctorHTML();
      window.history.pushState(nextDoctor, `${nextDoctor.name}`, `/doctors/${nextDoctor.slug}`);
      currentDoctor = nextDoctor;
      break;
  }
}

function previousDoctor() {
  let currentId = $('table').data('id');
  let currentDoctor = doctors.find(function(element) {
    return element.id === currentId;
  });
  let firstDoctor = doctors[0];
  let prevId;
  let prevDoctor;

  function usePreviousDoctorHTML() {
    $('#doctor-name').html(`${prevDoctor.name}`);
    $('#doctor-gender').html(`${prevDoctor.gender}`);
    $('#doctor-specialty').html(`${prevDoctor.specialty}`);
    $('#doctor-practice_name').html(`${prevDoctor.practiceName}`);
    $('#doctor-practice_location').html(`${prevDoctor.practiceLocation}`);
    $('#doctor-phone').html(`${prevDoctor.phone}`);
    $('#doctor-email').html(`${prevDoctor.email}`);
    $('table').data('id', prevId);
  }

  switch (currentDoctor) {
    default:
      prevId = idList[idList.indexOf(currentId) - 1];
      prevDoctor = doctors.find(function(element) {
        return element.id === prevId;
      });
      usePreviousDoctorHTML();
      window.history.pushState(prevDoctor, `${prevDoctor.name}`, `/doctors/${prevDoctor.slug}`);
      currentDoctor = prevDoctor;
      break;

    case firstDoctor:
      prevId = idList[doctors.length - 1];
      prevDoctor = doctors.find(function(element) {
        return element.id === prevId;
      });
      usePreviousDoctorHTML();
      window.history.pushState(prevDoctor, `${prevDoctor.name}`, `/doctors/${prevDoctor.slug}`);
      currentDoctor = prevDoctor;
      break;
  }
}
