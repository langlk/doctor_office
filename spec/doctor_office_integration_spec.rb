require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Administrative Portal', {:type => :feature}) do
  it "allows admin to add a new doctor" do
    visit('/admin')
    fill_in('doctor-name', :with => "Strange")
    fill_in('doctor-specialty', :with => "Surgeon")
    click_button('Add Doctor')
    click_link('Back to Administration')
    click_link('All Doctors')
    expect(page).to have_content("Strange")
  end

  it "allows admin to add a new patient" do
    visit('/admin')
    fill_in('doctor-name', :with => "Strange")
    fill_in('doctor-specialty', :with => "Surgeon")
    click_button('Add Doctor')
    click_link('Back to Administration')
    fill_in('patient-name', :with => "Frank")
    fill_in('patient-birthday', :with => "12-12-1950")
    select('Strange', :from => "assigned-doctor")
    click_button('Add Patient')
    click_link('Back to Administration')
    click_link('All Patients')
    expect(page).to have_content("Frank")
  end

  it "allows admin to edit an existing patient" do
    visit('/admin')
    fill_in('patient-name', :with => "Herbert")
    fill_in('patient-birthday', :with => "12-12-1950")
    click_button('Add Patient')
    click_link('Back to Administration')
    click_link('All Patients')
    click_link('Herbert')
    click_link('Edit')
    fill_in('patient-name', :with => "Harold")
    click_button('Update')
    expect(page).to have_content("Harold")
  end

  it "allows admin to edit an existing doctor" do
    visit('/admin')
    fill_in('doctor-name', :with => "Who")
    fill_in('doctor-specialty', :with => "Time")
    click_button('Add Doctor')
    click_link('Back to Administration')
    click_link('All Doctors')
    click_link('Who')
    click_link('Edit')
    fill_in('doctor-specialty', :with => "Space")
    click_button('Update')
    expect(page).to have_content('Space')
  end
end

describe('Doctor Portal', {:type => :feature}) do
  it "does not allow doctor to edit information" do
    visit('/admin')
    fill_in('doctor-name', :with => "Strange")
    fill_in('doctor-specialty', :with => "Surgeon")
    click_button('Add Doctor')
    visit('/doctor')
    fill_in('doctor-name', :with => "Strange")
    click_button('Submit')
    expect(page).to have_no_content('Edit')
  end
end

describe('Patient Portal', {:type => :feature}) do
  it "does not allow patient to edit information" do
    visit('/admin')
    fill_in('patient-name', :with => "Frank")
    fill_in('patient-birthday', :with => "12-12-1950")
    click_button('Add Patient')
    visit('/patient')
    fill_in('patient-name', :with => "Frank")
    click_button('Submit')
    expect(page).to have_no_content('Edit')
  end

  it "does not allow patient to view list of doctor's patients" do
    visit('/admin')
    fill_in('doctor-name', :with => "Strange")
    fill_in('doctor-specialty', :with => "Surgeon")
    click_button('Add Doctor')
    click_link('Back to Administration')
    fill_in('patient-name', :with => "Frank")
    fill_in('patient-birthday', :with => "12-12-1950")
    select('Strange', :from => "assigned-doctor")
    click_button('Add Patient')
    visit('/patient')
    fill_in('patient-name', :with => "Frank")
    click_button('Submit')
    click_link("Strange")
    expect(page).to have_no_content("Assigned Patients")
  end
end
