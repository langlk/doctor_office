#!/usr/bin/env ruby

class Patient
  attr_reader :id, :name, :birthday
  attr_accessor :doctor_id

  def initialize(attributes)
    @id = nil
    @doctor_id = -1
    if attributes.has_key?(:id)
      @id = attributes[:id]
    end
    if attributes.has_key?(:doctor_id)
      @doctor_id = attributes[:doctor_id]
    end
    @name = attributes[:name]
    @birthday = attributes[:birthday]
  end

  def ==(other_patient)
    ids_equal = @id == other_patient.id
    names_equal = @name == other_patient.name
    birthdays_equal = @birthday == other_patient.birthday
    doctors_equal = @doctor_id == other_patient.doctor_id
    ids_equal & names_equal & birthdays_equal & doctors_equal
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id}) RETURNING id;")
    @id = results.first["id"].to_i
  end

  def self.all
    all_patients = []
    results = DB.exec("SELECT * FROM patients;")
    results.each do |result|
      attributes = {}
      attributes[:id] = result["id"].to_i
      attributes[:name] = result["name"]
      attributes[:birthday] = result["birthday"][0...10]
      attributes[:doctor_id] = result["doctor_id"].to_i
      all_patients.push(Patient.new(attributes))
    end
    all_patients
  end

  def self.find(patient_id)
    results = DB.exec("SELECT * FROM patients WHERE id = #{patient_id};")
    if results.any?
      attributes = {}
      attributes[:id] = results.first["id"].to_i
      attributes[:name] = results.first["name"]
      attributes[:birthday] = results.first["birthday"][0...10]
      attributes[:doctor_id] = results.first["doctor_id"].to_i
      return Patient.new(attributes)
    else
      return nil
    end
  end

  def self.find_by_name(name)
    all_patients = self.all
    all_patients.each do |patient|
      if patient.name.downcase == name.downcase
        return patient
      end
    end
    nil
  end
end
