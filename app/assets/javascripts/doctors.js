class Doctor {
  constructor(id, name, gender, specialty, practiceName, practiceLocation, phone, email, slug) {
    this.id = id;
    this.name = name;
    this.gender = gender;
    this.specialty = specialty;
    this.practiceName = practiceName;
    this.practiceLocation = practiceLocation;
    this.phone = phone;
    this.email = email;
    this.slug = slug;
  }
}

let doctors = [];
let idList = [];

$(function() {
  $.getJSON('/doctors.json').success(function(data) {
    let i;
    for (i = 0; i < data.length; i++) {
      let d = new Doctor(
        data[i].id,
        data[i].name,
        data[i].gender,
        data[i].specialty,
        data[i].practice_name,
        data[i].practice_location,
        data[i].phone,
        data[i].email,
        data[i].slug);
      doctors.push(d);
    }
    doctors.map(doctor => idList.push(doctor.id));
  }).fail(function(jqXHR, textStatus, errorThrown) {
    const errorMessage = 'getJSON request failed! ' + textStatus + ' - ' + errorThrown;
    alert(errorMessage);
    console.log(errorMessage);
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

  switch (currentDoctor) {
    default:
      nextId = idList[idList.indexOf(currentId) + 1];
      nextDoctor = doctors.find(function(element) {
        return element.id === nextId;
      });
      $('#doctor-name').html(`${nextDoctor.name}`);
      $('#doctor-gender').html(`${nextDoctor.gender}`);
      $('#doctor-specialty').html(`${nextDoctor.specialty}`);
      $('#doctor-practice_name').html(`${nextDoctor.practiceName}`);
      $('#doctor-practice_location').html(`${nextDoctor.practiceLocation}`);
      $('#doctor-phone').html(`${nextDoctor.phone}`);
      $('#doctor-email').html(`${nextDoctor.email}`);
      $('table').data('id', nextId);
      window.history.pushState(nextDoctor, `${nextDoctor.name}`, `/doctors/${nextDoctor.slug}`);
      currentDoctor = nextDoctor;
      break;

    case lastDoctor:
      nextId = idList[0];
      nextDoctor = doctors.find(function(element) {
        return element.id === nextId;
      });
      $('#doctor-name').html(`${nextDoctor.name}`);
      $('#doctor-gender').html(`${nextDoctor.gender}`);
      $('#doctor-specialty').html(`${nextDoctor.specialty}`);
      $('#doctor-practice_name').html(`${nextDoctor.practiceName}`);
      $('#doctor-practice_location').html(`${nextDoctor.practiceLocation}`);
      $('#doctor-phone').html(`${nextDoctor.phone}`);
      $('#doctor-email').html(`${nextDoctor.email}`);
      $('table').data('id', nextId);
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

  switch (currentDoctor) {
    default:
      prevId = idList[idList.indexOf(currentId) - 1];
      prevDoctor = doctors.find(function(element) {
        return element.id === prevId;
      });
      $('#doctor-name').html(`${prevDoctor.name}`);
      $('#doctor-gender').html(`${prevDoctor.gender}`);
      $('#doctor-specialty').html(`${prevDoctor.specialty}`);
      $('#doctor-practice_name').html(`${prevDoctor.practiceName}`);
      $('#doctor-practice_location').html(`${prevDoctor.practiceLocation}`);
      $('#doctor-phone').html(`${prevDoctor.phone}`);
      $('#doctor-email').html(`${prevDoctor.email}`);
      $('table').data('id', prevId);
      window.history.pushState(prevDoctor, `${prevDoctor.name}`, `/doctors/${prevDoctor.slug}`);
      currentDoctor = prevDoctor;
      break;

    case firstDoctor:
      prevId = idList[doctors.length - 1];
      prevDoctor = doctors.find(function(element) {
        return element.id === prevId;
      });
      $('#doctor-name').html(`${prevDoctor.name}`);
      $('#doctor-gender').html(`${prevDoctor.gender}`);
      $('#doctor-specialty').html(`${prevDoctor.specialty}`);
      $('#doctor-practice_name').html(`${prevDoctor.practiceName}`);
      $('#doctor-practice_location').html(`${prevDoctor.practiceLocation}`);
      $('#doctor-phone').html(`${prevDoctor.phone}`);
      $('#doctor-email').html(`${prevDoctor.email}`);
      $('table').data('id', prevId);
      window.history.pushState(prevDoctor, `${prevDoctor.name}`, `/doctors/${prevDoctor.slug}`);
      currentDoctor = prevDoctor;
      break;
  }
}
