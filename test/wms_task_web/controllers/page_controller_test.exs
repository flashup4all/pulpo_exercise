defmodule WmsTaskWeb.PageControllerTest do
  use WmsTaskWeb.ConnCase

  @valid_login_data %{"username" => "felipe_user1", "password" => "felipe_user1"}

  describe("authentication") do
    test "GET /login", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :auth), @valid_login_data)

      assert %{
               "access_token" => access_token,
               "expires_in" => expires_in,
               "token_type" => "bearer"
             } = json_response(conn, 200)
    end
  end

  describe("Get orders") do
    setup %{auth_conn: auth_conn} do
      {:ok, auth_conn: put_req_header(auth_conn, "accept", "application/json")}
    end

    test "GET /orders/live", %{auth_conn: auth_conn} do
      conn = get(auth_conn, "/orders/live")
      response = json_response(conn, 200)
      assert response
      assert Map.has_key?(response, "orders")
    end

    test "sync", %{auth_conn: auth_conn} do
      # WmsTaskWeb.PageController.sync_orders(auth_conn, 5000)
      conn = get(auth_conn, "/orders")
      response = json_response(conn, 200)
      assert response
      assert Map.has_key?(response, "orders")
    end
  end
end
