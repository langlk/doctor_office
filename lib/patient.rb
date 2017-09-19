#!/usr/bin/env ruby

class Patient
  attr_reader :id, :name, :birthday
  attr_accessor :doctor_id

  def initialize(attributes)
    @id = nil
    @doctor_id = nil
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
end
