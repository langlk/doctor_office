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
end
