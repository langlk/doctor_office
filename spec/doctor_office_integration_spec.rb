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

  it "allows admin to add a new doctor" do
    visit('/admin')
    fill_in('patient-name', :with => "Frank")
    fill_in('patient-birthday', :with => "12-12-1950")
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
end
