defmodule WmsTaskWeb.PageControllerTest do
  use WmsTaskWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "GET /orders/live", %{conn: conn} do
    conn = get(conn, "/orders/live")
    response = json_response(conn, 200)
    assert response |> IO.inspect
    assert length(response["orders"]) == 10
  end

  test "sync", %{conn: conn} do
    WmsTaskWeb.PageController.sync_orders(5000)
    conn = get(conn, "/orders")
    response = json_response(conn, 200)
    assert response |> IO.inspect
    assert length(response["orders"]) == 10
  end
end
