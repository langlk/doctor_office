require "sinatra"
require "sinatra/reloader"
also_reload "lib/**/*.rb"
require "pg"
require "./lib/doctor"
require "./lib/patient"
require "pry"

DB = PG.connect({:dbname => "doctor_office_test"})

get('/') do
  erb(:index)
end

get('/doctor') do
  erb(:doctor_portal)
end

get('/doctor/info') do
  @doctor = Doctor.find_by_name(params["doctor-name"])
  erb(:doctor_info)
end

get('/patient') do
  erb(:patient_portal)
end

get('/patient/info') do
  @patient = Patient.find_by_name(params["patient-name"])
  erb(:patient_info)
end

get('/admin') do
  @doctors = Doctor.all
  erb(:admin_portal)
end

get('/admin/:people_type') do
  @people_type = params[:people_type]
  @people = []
  if @people_type == "doctors"
    @people = Doctor.all
  elsif @people_type == "patients"
    @people = Patient.all
  end
  erb(:people_list)
end

get('/admin/patients/:id') do
  @patient = Patient.find(params[:id].to_i)
  erb(:admin_patient)
end

get('/admin/patients/edit/:id') do
  @patient = Patient.find(params[:id].to_i)
  @doctors = Doctor.all
  erb(:edit_patient)
end

post('/admin/patients/edit/:id') do
  patient = Patient.find(params[:id].to_i)
  patient.name = params["patient-name"]
  patient.birthday = params["patient-birthday"]
  patient.doctor_id = params["assigned-doctor"].to_i
  patient.save
  redirect "/admin/patients/#{patient.id}"
end

get('/admin/doctors/:id') do
  @doctor = Doctor.find(params[:id].to_i)
  erb(:admin_doctor)
end

post('/add_doctor') do
  name = params["doctor-name"]
  specialty = params["doctor-specialty"]
  @add_person = Doctor.new({:name => name, :specialty => specialty})
  @add_person.save
  erb(:add_success)
end

post('/add_patient') do
  name = params["patient-name"]
  birthday = params["patient-birthday"]
  doctor_id = params["assigned-doctor"]
  @add_person = Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id})
  @add_person.save
  erb(:add_success)
end
