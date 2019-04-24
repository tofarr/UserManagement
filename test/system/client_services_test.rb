require "application_system_test_case"

class ClientServicesTest < ApplicationSystemTestCase
  setup do
    @client_service = client_services(:one)
  end

  test "visiting the index" do
    visit client_services_url
    assert_selector "h1", text: "Client Services"
  end

  test "creating a Client service" do
    visit client_services_url
    click_on "New Client Service"

    fill_in "Algorithm", with: @client_service.algorithm
    fill_in "Expire at", with: @client_service.expire_at
    fill_in "Secret", with: @client_service.secret
    check "Suspended" if @client_service.suspended
    fill_in "Token timeout", with: @client_service.token_timeout
    click_on "Create Client service"

    assert_text "Client service was successfully created"
    click_on "Back"
  end

  test "updating a Client service" do
    visit client_services_url
    click_on "Edit", match: :first

    fill_in "Algorithm", with: @client_service.algorithm
    fill_in "Expire at", with: @client_service.expire_at
    fill_in "Secret", with: @client_service.secret
    check "Suspended" if @client_service.suspended
    fill_in "Token timeout", with: @client_service.token_timeout
    click_on "Update Client service"

    assert_text "Client service was successfully updated"
    click_on "Back"
  end

  test "destroying a Client service" do
    visit client_services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client service was successfully destroyed"
  end
end
