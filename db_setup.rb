require 'pg'

control = PG.connect(dbname: "postgres")
control.exec('CREATE DATABASE doctor_office;')
db = PG.connect(dbname: 'doctor_office')
db.exec("CREATE TABLE doctors (id serial PRIMARY KEY, name varchar, specialty varchar);")
db.exec("CREATE TABLE patients (id serial PRIMARY KEY, name varchar, birthday timestamp, doctor_id int);")
db.exec("CREATE DATABASE doctor_office_test WITH TEMPLATE doctor_office;")
