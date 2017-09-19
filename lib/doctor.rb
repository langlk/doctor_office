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

  def self.all
    all_doctors = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |result|
      all_doctors.push(Doctor.new({:id => result["id"].to_i, :name => result["name"], :specialty => result["specialty"]}))
    end
    all_doctors
  end
end
