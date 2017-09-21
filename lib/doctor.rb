#!/usr/bin/env ruby

class Doctor
  attr_reader :id
  attr_accessor :name, :specialty

  def initialize(attributes)
    @id = attributes[:id] || nil
    @name = attributes[:name]
    @specialty = attributes[:specialty]
  end

  def ==(other_doctor)
    (@id == other_doctor.id) &
    (@name == other_doctor.name) &
    (@specialty == other_doctor.specialty)
  end

  def save
    if @id # doc has been added already, update in DB
      DB.exec("UPDATE doctors SET name = '#{@name}', specialty='#{@specialty}' WHERE id = #{@id};")
    else # doctor is new, insert into database
      results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
      @id = results.first["id"].to_i
    end
  end

  def patients
    results = DB.exec("SELECT * FROM patients WHERE doctor_id = #{@id};")
    results.map do |result|
      Patient.new({
        id: result["id"].to_i,
        name: result["name"],
        birthday: result["birthday"][0...10],
        doctor_id: result["doctor_id"].to_i
      })
    end
  end

  def delete
    DB.exec("DELETE FROM doctors WHERE id = #{@id};")
    DB.exec("UPDATE patients SET doctor_id = -1 WHERE doctor_id = #{@id};")
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
