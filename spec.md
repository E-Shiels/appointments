# Specifications for the Rails Assessment

Specs:

- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (Doctor and Patient has many appointments)
- [x] Include at least one belongs_to relationship (Appointment belongs_to Patient and Doctor)
- [x] Include at least two has_many through relationships (Doctor has many patients through appointments and vice versa)

- [ ] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)

- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (appointment time, date, description)
- [x] Include reasonable validations for simple model objects (all models have some validations)
- [x] Include a class level ActiveRecord scope method (appointment.today and appointment.this_week - /doctors/{doctor name goes here})
- [x] Include signup
- [x] Include login
- [x] Include logout (clear session - logout button)
- [x] Include third party signup/login (GitHub)
- [x] Include nested resource show or index (appointments/{appointment id goes here})
- [x] Include nested resource "new" form (/doctors/{doctor name goes here}/appointments/new)
- [x] Include form display of validation errors (/doctors/new)

Confirm:

- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
