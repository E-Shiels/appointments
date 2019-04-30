// class Patient {
//   constructor(id, name, gender, age, address, phone, email, slug) {
//     this.id = id;
//     this.name = name;
//     this.gender = gender;
//     this.age = age;
//     this.address = address;
//     this.phone = phone;
//     this.email = email;
//     this.slug = slug;
//   }
// }


//ES5 Object Constructor
function Patient(obj) {
      this.id = obj.id;
      this.name = obj.name;
      this.gender = obj.gender;
      this.age = obj.age;
      this.address = obj.address;
      this.phone = obj.phone;
      this.email = obj.email;
      this.slug = obj.slug;
}

$(function() {
  let doctorsList = [];
  //Create list of unique doctors for patient instance
  $.getJSON(window.location.pathname).success(function(data) {
    let doctorIds = [];
    for (let i = 0; i < data.doctors.length; i++) {
      let newDoctor = true;
      for (let j = 0; j < doctorIds.length; j++) {
        if (doctorIds[j] === data.doctors[i].id) {
          newDoctor = false;
          break;
        }
      }
      if (newDoctor) {
        doctorIds.push(data.doctors[i].id);
        let doctor = data.doctors[i];
        let d = new Doctor({
          id: doctor.id,
          name: doctor.name,
          // "",
          specialty: doctor.specialty,
          // "",
          // "",
          // "",
          // "",
          slug: doctor.slug});
        doctorsList.push(d);
      }
    }

  }).then(function() {
    doctorsList.forEach(function(doctor) {
      $('#patient-doctors-section').append(`<table id="patient-doctors-list" data-id="${doctor.id}"></table>`);
      const $patientDoctorsList = $(`#patient-doctors-list[data-id='${doctor.id}']`);
      $patientDoctorsList.append(`<tr><th>Name</th><td><a href="/doctors/${doctor.slug}">${doctor.name}</a></td></tr>`);
      $patientDoctorsList.append(`<tr><th>Specialty</th><td>${doctor.specialty}</td></tr>`);
      $patientDoctorsList.after(`<hr>`);
    });
  });
});
