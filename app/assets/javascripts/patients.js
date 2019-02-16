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
   let doctors = [];
   $.getJSON(path).success(function(data) {
     data.doctors.forEach(function(element) {

     })
   });
 });
