function Patient(t){this.id=t.id,this.name=t.name,this.gender=t.gender,this.age=t.age,this.address=t.address,this.phone=t.phone,this.email=t.email,this.slug=t.slug}$(function(){let t=[];$.getJSON(window.location.pathname).success(function(e){let i=[];for(let a=0;a<e.doctors.length;a++){let s=!0;for(let t=0;t<i.length;t++)if(i[t]===e.doctors[a].id){s=!1;break}if(s){i.push(e.doctors[a].id);let s=e.doctors[a],d=new Doctor({id:s.id,name:s.name,specialty:s.specialty,slug:s.slug});t.push(d)}}}).then(function(){t.forEach(function(t){$("#patient-doctors-section").append(`<table id="patient-doctors-list" data-id="${t.id}"></table>`);const e=$(`#patient-doctors-list[data-id='${t.id}']`);e.append(`<tr><th>Name</th><td><a href="/doctors/${t.slug}">${t.name}</a></td></tr>`),e.append(`<tr><th>Specialty</th><td>${t.specialty}</td></tr>`),e.after("<hr>")})})});