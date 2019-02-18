class Patient {
  constructor(r_id, name, gender, age, address, phone, email, slug) {
    this.r_id = r_id;
    this.name = name;
    this.gender = gender;
    this.age = age;
    this.address = address;
    this.phone = phone;
    this.email = email;
    this.slug = slug;
  }
}

$(function() {
  let path = window.location.pathname;
  let doctorsList = [];

  $.getJSON(path).success(function(data) {
    let doctorIds = [];
    for (let i = 0; i < data.doctors.length; i++) {
      let newDoctor = true;
      for(let j = 0; j < doctorIds.length; j++) {
        if( doctorIds[j] === data.doctors[i].id){
          newDoctor = false;
          break;
        }
      }
      if( newDoctor ) {
        doctorIds.push(data.doctors[i].id);
        let doctor = data.doctors[i];
        let d = new Doctor(
          doctor.id,
          doctor.name,
          "",
          doctor.specialty,
          "",
          "",
          "",
          "",
          doctor.slug);
          doctorsList.push(d);
        }
      }

    }).then(function() {
      doctorsList.forEach(function(doctor) {
        $('#patient-doctors-section').append(`<table id="patient-doctors-list"><th><td>${doctor.name}</td></th></table>`);
      });
    }
  );
});
