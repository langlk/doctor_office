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
end
