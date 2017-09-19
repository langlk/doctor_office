#!/usr/bin/env ruby

class Doctor
  attr_reader :id, :name, :specialty

  def initialize(attributes)
    if attributes.has_key?(:id)
      @id = attributes[:id]
    else
      @id = nil
    end
    @name = attributes[:name]
    @specialty = attributes[:specialty]
  end

  def ==(other_doctor)
    ids_equal = @id == other_doctor.id
    names_equal = @name == other_doctor.name
    specialties_equal = @specialty == other_doctor.specialty
    ids_equal & names_equal & specialties_equal
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = results.first["id"].to_i
  end

  def patients
    assigned_patients = []
    results = DB.exec("SELECT * FROM patients WHERE doctor_id = #{@id};")
    results.each do |result|
      attributes = {}
      attributes[:id] = result["id"].to_i
      attributes[:name] = result["name"]
      attributes[:birthday] = result["birthday"][0...10]
      attributes[:doctor_id] = result["doctor_id"].to_i
      assigned_patients.push(Patient.new(attributes))
    end
    assigned_patients
  end

  def self.all
    all_doctors = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |result|
      all_doctors.push(Doctor.new({:id => result["id"].to_i, :name => result["name"], :specialty => result["specialty"]}))
    end
    all_doctors
  end

  def self.find(doctor_id)
    results = DB.exec("SELECT * FROM doctors WHERE id = #{doctor_id};")
    if results.any?
      id = results.first["id"].to_i
      name = results.first["name"]
      specialty = results.first["specialty"]
      return Doctor.new({:id => id, :name => name, :specialty => specialty})
    else
      return nil
    end
  end

  def self.find_by_name(name)
    all_doctors = self.all
    all_doctors.each do |doctor|
      if doctor.name.downcase == name.downcase
        return doctor
      end
    end
    nil
  end
end
