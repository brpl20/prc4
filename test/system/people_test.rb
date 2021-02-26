require "application_system_test_case"

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:one)
  end

  test "visiting the index" do
    visit people_url
    assert_selector "h1", text: "People"
  end

  test "creating a Person" do
    visit people_url
    click_on "New Person"

    fill_in "Adress", with: @person.adress
    fill_in "Birth", with: @person.birth
    fill_in "Capacity", with: @person.capacity
    fill_in "Citizenship", with: @person.citizenship
    fill_in "City", with: @person.city
    fill_in "Civilstatus", with: @person.civilstatus
    fill_in "Company", with: @person.company
    fill_in "Email", with: @person.email
    fill_in "First name", with: @person.first_name
    fill_in "Gender", with: @person.gender
    fill_in "General register", with: @person.general_register
    fill_in "Lastname", with: @person.lastname
    fill_in "Life", with: @person.life
    fill_in "Mothername", with: @person.mothername
    fill_in "Number benefit", with: @person.number_benefit
    fill_in "Oab number", with: @person.oab_number
    fill_in "Profession", with: @person.profession
    fill_in "Social number", with: @person.social_number
    fill_in "State", with: @person.state
    fill_in "Status", with: @person.status
    fill_in "Zip", with: @person.zip
    click_on "Create Person"

    assert_text "Person was successfully created"
    click_on "Back"
  end

  test "updating a Person" do
    visit people_url
    click_on "Edit", match: :first

    fill_in "Adress", with: @person.adress
    fill_in "Birth", with: @person.birth
    fill_in "Capacity", with: @person.capacity
    fill_in "Citizenship", with: @person.citizenship
    fill_in "City", with: @person.city
    fill_in "Civilstatus", with: @person.civilstatus
    fill_in "Company", with: @person.company
    fill_in "Email", with: @person.email
    fill_in "First name", with: @person.first_name
    fill_in "Gender", with: @person.gender
    fill_in "General register", with: @person.general_register
    fill_in "Lastname", with: @person.lastname
    fill_in "Life", with: @person.life
    fill_in "Mothername", with: @person.mothername
    fill_in "Number benefit", with: @person.number_benefit
    fill_in "Oab number", with: @person.oab_number
    fill_in "Profession", with: @person.profession
    fill_in "Social number", with: @person.social_number
    fill_in "State", with: @person.state
    fill_in "Status", with: @person.status
    fill_in "Zip", with: @person.zip
    click_on "Update Person"

    assert_text "Person was successfully updated"
    click_on "Back"
  end

  test "destroying a Person" do
    visit people_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Person was successfully destroyed"
  end
end
