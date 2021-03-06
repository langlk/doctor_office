#!/usr/bin/env ruby

require "spec-helper"

describe('Doctor') do
  it "stores the name, id, and specialty of a doctor" do
    doc_test = Doctor.new({:id => 1, :name => "Strange", :specialty => "Surgeon"})
    expect(doc_test.name).to(eq("Strange"))
    expect(doc_test.specialty).to(eq("Surgeon"))
    expect(doc_test.id).to(eq(1))
  end

  describe('#id') do
    it "initializes to nil if no id provided in attributes" do
      doc_test = Doctor.new({:name => "Strange", :specialty => "Surgeon"})
      expect(doc_test.id).to(eq(nil))
    end
  end

  describe('#==') do
    it "declares two Doctors not equal if their names, specialties, or ids are not equal" do
      doc1 = Doctor.new({:id => 1, :name => "Strange", :specialty => "Magic"})
      doc2 = Doctor.new({:id => 1, :name => "Strange", :specialty => "Surgeon"})
      expect(doc1).not_to(eq(doc2))
    end

    it "delcares two Doctors equal if they have the same name, specialty, and id" do
      doc1 = Doctor.new({:id => 1, :name => "Strange", :specialty => "Surgeon"})
      doc2 = Doctor.new({:id => 1, :name => "Strange", :specialty => "Surgeon"})
      expect(doc1).to(eq(doc2))
    end
  end

  describe('#save') do
    it "updates a Doctor if they are already in a database, and keeps id the same" do
      doc_test = Doctor.new({:name => "Strange", :specialty => "Surgeon"})
      doc_test.save
      test_id = doc_test.id
      doc_test.name = "Stephen Strange"
      doc_test.save
      expect(doc_test.id).to(eq(test_id))
      expect(Doctor.find(doc_test.id)).to(eq(doc_test))
    end
  end

  describe('#patients') do
    it "returns an array of all patients assigned to a doctor" do
      doc_test = Doctor.new({:name => "Strange", :specialty => "Surgeon"})
      doc_test.save
      attributes1 = {:name => "Frank", :birthday => "1990-01-01", :doctor_id => doc_test.id}
      attributes2 = {:name => "Herbert", :birthday => "1990-01-01", :doctor_id => doc_test.id}
      patient1 = Patient.new(attributes1)
      patient1.save
      patient2 = Patient.new(attributes2)
      patient2.save
      expect(doc_test.patients).to(eq([patient1, patient2]))
    end
  end

  describe('#delete') do
    it "delets doctor from the database" do
      doc_test = Doctor.new({:name => "Strange", :specialty => "Surgeon"})
      doc_test.save
      doc_test.delete
      expect(Doctor.all).to(eq([]))
    end
  end

  describe('.all') do
    it "starts out with an empty array" do
      expect(Doctor.all).to(eq([]))
    end

    it "returns an array of all saved doctors" do
      doc1 = Doctor.new({:name => "Strange", :specialty => "Surgeon"})
      doc1.save
      doc2 = Doctor.new({:name => "Who", :specialty => "Time"})
      doc2.save
      expect(Doctor.all).to(eq([doc1, doc2]))
    end
  end

  describe('.find') do
    it "finds a saved doctor by their id" do
      doc1 = Doctor.new({:name => "Strange", :specialty => "Surgeon"})
      doc1.save
      doc2 = Doctor.new({:name => "Who", :specialty => "Time"})
      doc2.save
      expect(Doctor.find(doc1.id)).to(eq(doc1))
    end
  end

  describe('.find_by_name') do
    it "finds a saved doctor by name, ignoring case" do
      doc1 = Doctor.new({:name => "Strange", :specialty => "Surgeon"})
      doc1.save
      doc2 = Doctor.new({:name => "Who", :specialty => "Time"})
      doc2.save
      expect(Doctor.find_by_name("strange")).to(eq(doc1))
    end
  end
end
