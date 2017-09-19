#!/usr/bin/env ruby

require "spec-helper"

describe('Patient') do
  it "saves the name, id, birthday, and doctor_id of a patient" do
    attributes = {:name => "Frank", :birthday => "1990-01-01", :doctor_id => 1, :id => 5}
    patient_test = Patient.new(attributes)
    expect(patient_test.name).to(eq("Frank"))
    expect(patient_test.id).to(eq(5))
    expect(patient_test.doctor_id).to(eq(1))
    expect(patient_test.birthday).to(eq("1990-01-01"))
  end

  describe('#id') do
    it "starts out as nil" do
      attributes = {:name => "Frank", :birthday => "1990-01-01"}
      patient_test = Patient.new(attributes)
      expect(patient_test.id).to(eq(nil))
    end
  end

  describe('#doctor_id') do
    it "starts out as nil" do
      attributes = {:name => "Frank", :birthday => "1990-01-01"}
      patient_test = Patient.new(attributes)
      expect(patient_test.doctor_id).to(eq(nil))
    end

    it "can be set by user" do
      attributes = {:name => "Frank", :birthday => "1990-01-01"}
      patient_test = Patient.new(attributes)
      patient_test.doctor_id = 1
      expect(patient_test.doctor_id).to(eq(1))
    end
  end

  describe('#==') do
    it "declares two patients as unequal if they don't have the same name, id, birthday, and doctor" do
      attributes = {:name => "Frank", :birthday => "1990-01-01"}
      patient1 = Patient.new(attributes)
      patient2 = Patient.new(attributes)
      patient2.doctor_id = 5
      expect(patient1).not_to(eq(patient2))
    end

    it "declares two patients as equal if they have the same name, id, birthday, and doctor" do
      attributes = {:name => "Frank", :birthday => "1990-01-01"}
      patient1 = Patient.new(attributes)
      patient2 = Patient.new(attributes)
      expect(patient1).to(eq(patient2))
    end
  end
end
