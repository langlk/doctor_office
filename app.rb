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

get('/doctor_portal') do
  erb(:doctor_portal)
end

get('/patient_portal') do
  erb(:patient_portal)
end

get('/admin_portal') do
  @doctors = Doctor.all
  erb(:admin_portal)
end
