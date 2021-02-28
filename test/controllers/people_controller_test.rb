require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post people_url, params: { person: { address: @person.address, birth: @person.birth, capacity: @person.capacity, citizenship: @person.citizenship, city: @person.city, civilstatus: @person.civilstatus, company: @person.company, email: @person.email, first_name: @person.first_name, gender: @person.gender, general_register: @person.general_register, lastname: @person.lastname, life: @person.life, mothername: @person.mothername, number_benefit: @person.number_benefit, oab_number: @person.oab_number, profession: @person.profession, social_number: @person.social_number, state: @person.state, status: @person.status, zip: @person.zip } }
    end

    assert_redirected_to person_url(Person.last)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { address: @person.address, birth: @person.birth, capacity: @person.capacity, citizenship: @person.citizenship, city: @person.city, civilstatus: @person.civilstatus, company: @person.company, email: @person.email, first_name: @person.first_name, gender: @person.gender, general_register: @person.general_register, lastname: @person.lastname, life: @person.life, mothername: @person.mothername, number_benefit: @person.number_benefit, oab_number: @person.oab_number, profession: @person.profession, social_number: @person.social_number, state: @person.state, status: @person.status, zip: @person.zip } }
    assert_redirected_to person_url(@person)
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete person_url(@person)
    end

    assert_redirected_to people_url
  end
end
