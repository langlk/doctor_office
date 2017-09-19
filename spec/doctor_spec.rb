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
end
