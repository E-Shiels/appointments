class Doctor {
  constructor(r_id, name, gender, specialty, practiceName, practiceLocation, phone, email, slug) {
    this.r_id = r_id;
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
      doctors.map(d => idList.push(d.r_id));
    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('getJSON request failed! ' + textStatus);
      console.log('getJSON request failed! ' + textStatus);
    });

    $(document).on('click', '#next-doctor-button', function() {
      let currentId = $('table').data('id');
      let currentDoctor = doctors.find(function(element) {
        return element.r_id === currentId;
      });
      let lastDoctor = doctors[doctors.length - 1];
      let nextId;
      let nextDoctor;
      switch (currentDoctor) {
        default:
        nextId = idList[idList.indexOf(currentId) + 1];
        nextDoctor = doctors.find(function(element) {
          return element.r_id === nextId;
        });
        $('#doctor-name').html(`${nextDoctor.name}`);
        $('#doctor-gender').html(`${nextDoctor.gender}`);
        $('#doctor-specialty').html(`${nextDoctor.specialty}`);
        $('#doctor-practice_name').html(`${nextDoctor.practiceName}`);
        $('#doctor-practice_location').html(`${nextDoctor.practiceLocation}`);
        $('#doctor-phone').html(`${nextDoctor.phone}`);
        $('#doctor-email').html(`${nextDoctor.email}`);
        $('table').data('id', nextId);
        window.history.pushState(nextDoctor,`${nextDoctor.name}`,`/doctors/${nextDoctor.slug}`);
        currentDoctor = nextDoctor;
        break;
        case lastDoctor:
        nextId = idList[0];
        nextDoctor = doctors.find(function(element) {
          return element.r_id === nextId;
        });
        $('#doctor-name').html(`${nextDoctor.name}`);
        $('#doctor-gender').html(`${nextDoctor.gender}`);
        $('#doctor-specialty').html(`${nextDoctor.specialty}`);
        $('#doctor-practice_name').html(`${nextDoctor.practiceName}`);
        $('#doctor-practice_location').html(`${nextDoctor.practiceLocation}`);
        $('#doctor-phone').html(`${nextDoctor.phone}`);
        $('#doctor-email').html(`${nextDoctor.email}`);
        $('table').data('id', nextId);
        window.history.pushState(nextDoctor,`${nextDoctor.name}`,`/doctors/${nextDoctor.slug}`);
        currentDoctor = nextDoctor;
        break;
      }
    });
  });
