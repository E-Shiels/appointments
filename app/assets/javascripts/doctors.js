class Doctor {
  constructor(name, gender, speciality, practice_name, practice_location, phone, email) {
    this.name = name;
    this.gender = gender;
    this.speciality = speciality;
    this.practice_name = practice_name;
    this.practice_location = practice_location;
    this.phone = phone;
    this.email = email;
  }
}

$(function() {
  $.getJSON('/doctors.json').success(function(data) {
    let i;
    let doctors = [];

    for (i = 0; i < data.length; i++) {
      let d = new Doctor(
        data[i].name,
        data[i].gender,
        data[i].specialty,
        data[i].practice_name,
        data[i].practice_location,
        data[i].phone,
        data[i].email);
      doctors.push(d);
    }
  });
});
