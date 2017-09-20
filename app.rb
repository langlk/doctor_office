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

get('/:user') do
  @user = params[:user]
  erb(:portal)
end

get('/:user/landing') do
  @user = params[:user]
  if @user == "doctor"
    @doctor = Doctor.find_by_name(params["doctor-name"])
    @user = "doctor"
    return erb(:doctor)
  elsif @user == "admin"
    @doctors = Doctor.all
    erb(:admin_portal)
  else
    @patient = Patient.find_by_name(params["patient-name"])
    @user = "patient"
    erb(:patient)
  end
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

get('/:user/patients/:id') do
  @patient = Patient.find(params[:id].to_i)
  @user = params[:user]
  erb(:patient)
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

post('/admin/patients/delete/:id') do
  patient = Patient.find(params[:id].to_i)
  patient.delete
  redirect '/admin/patients'
end

get('/:user/doctors/:id') do
  @doctor = Doctor.find(params[:id].to_i)
  @user = params[:user]
  erb(:doctor)
end

get('/admin/doctors/edit/:id') do
  @doctor = Doctor.find(params[:id].to_i)
  erb(:edit_doctor)
end

post('/admin/doctors/edit/:id') do
  doctor = Doctor.find(params[:id].to_i)
  doctor.name = params["doctor-name"]
  doctor.specialty = params["doctor-specialty"]
  doctor.save
  redirect "/admin/doctors/#{doctor.id}"
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
