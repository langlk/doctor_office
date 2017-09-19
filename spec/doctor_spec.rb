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
end
