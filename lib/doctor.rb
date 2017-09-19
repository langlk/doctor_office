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
end
