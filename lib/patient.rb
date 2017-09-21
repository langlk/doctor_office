#!/usr/bin/env ruby

class Patient
  attr_reader :id
  attr_accessor :doctor_id, :name, :birthday

  def initialize(attributes)
    @id = attributes[:id] || nil
    @doctor_id = attributes[:doctor_id] || -1
    @name = attributes[:name]
    @birthday = attributes[:birthday]
  end

  def ==(other_patient)
    (@id == other_patient.id) &
    (@name == other_patient.name) &
    (@birthday == other_patient.birthday) &
    (@doctor_id == other_patient.doctor_id)
  end

  def save
    if @id # patient has id, has been saved
      DB.exec("UPDATE patients SET name = '#{@name}', birthday = '#{@birthday}', doctor_id = #{@doctor_id} WHERE id = #{@id};")
    else # id is nil, patient is new
      results = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id}) RETURNING id;")
      @id = results.first["id"].to_i
    end
  end

  def delete
    DB.exec("DELETE FROM patients WHERE id = #{@id};")
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    results.map do |result|
      Patient.new({
        id: result["id"].to_i,
        name: result["name"],
        birthday: result["birthday"][0...10],
        doctor_id: result["doctor_id"].to_i
      })
    end
  end

  def self.find(patient_id)
    results = DB.exec("SELECT * FROM patients WHERE id = #{patient_id};")
    if results.any?
      return Patient.new({
        id: results.first["id"].to_i,
        name: results.first["name"],
        birthday: results.first["birthday"][0...10],
        doctor_id: results.first["doctor_id"].to_i
      })
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
