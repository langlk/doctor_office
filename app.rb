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

get('/patient') do
  erb(:patient_portal)
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
