require 'test_helper'

class ClientServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_service = client_services(:one)
  end

  test "should get index" do
    get client_services_url
    assert_response :success
  end

  test "should get new" do
    get new_client_service_url
    assert_response :success
  end

  test "should create client_service" do
    assert_difference('ClientService.count') do
      post client_services_url, params: { client_service: { algorithm: @client_service.algorithm, expire_at: @client_service.expire_at, secret: @client_service.secret, suspended: @client_service.suspended, token_timeout: @client_service.token_timeout } }
    end

    assert_redirected_to client_service_url(ClientService.last)
  end

  test "should show client_service" do
    get client_service_url(@client_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_service_url(@client_service)
    assert_response :success
  end

  test "should update client_service" do
    patch client_service_url(@client_service), params: { client_service: { algorithm: @client_service.algorithm, expire_at: @client_service.expire_at, secret: @client_service.secret, suspended: @client_service.suspended, token_timeout: @client_service.token_timeout } }
    assert_redirected_to client_service_url(@client_service)
  end

  test "should destroy client_service" do
    assert_difference('ClientService.count', -1) do
      delete client_service_url(@client_service)
    end

    assert_redirected_to client_services_url
  end
end
