defmodule WmsTaskWeb.PageController do
  use WmsTaskWeb, :controller

  require Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_headers(host, user) do
    #TODO do we need both headers?
    headers = ["Accept": "Application/json; Charset=utf-8", "Content-Type": "application/json"]
    body = "{\"username\": \"#{user}\", \"password\": \"#{user}\", \"grant_type\": \"password\", \"scope\": \"profile\"}"
    response1 = HTTPoison.post!(
      host<>"/api/v1/auth",
      body,
      headers
    )
    IO.inspect(response1)

    token = Poison.decode!(response1.body)["access_token"]
    headers = ["Authorization": "Bearer #{token}", "Accept": "Application/json; Charset=utf-8"]
    #response1 = HTTPoison.get!(host<>"/api/v1/iam/users/me", headers)

    headers
  end

  def get_orders_live(conn, params) do
    host = "https://show.pulpo.co"
    user = "felipe_user1"

    orders3 = get_orders_in_interval(host, user)
    render(conn, "orders.json", orders: %{"sales_orders" => orders3})
  end

  defp get_orders_in_interval(host,user, interval \\ nil) do

    between =
    case interval do
      nil -> ""
      interval ->
      to = DateTime.utc_now()
      from = DateTime.add(to, -300000, :second)
      "?updated_at=between:#{DateTime.to_iso8601(from)},#{DateTime.to_iso8601(to)}"
    end

    headers = get_headers(host, user)
    response1 = HTTPoison.get!(host<>"/api/v1/sales/orders#{between}" |> IO.inspect, headers)
    orders = Poison.decode!(response1.body)


    orders2 = Enum.map(
      orders["sales_orders"],
      fn order ->
        order_num = order["order_num"]
        pickings = HTTPoison.get!(host<>"/api/v1/picking/orders?__or_search=sales_order_num%7Ccontains%3A#{order_num}&limit=20", headers)
                   |> Map.get(:body)
                   |> Poison.decode!()
        picking = List.first(pickings["picking_orders"])
        Map.put(order, "picking", picking)
      end)

    packings = WmsTask.get_packings(host, user, orders2)
    orders3 = WmsTask.map_packings(orders2, packings)
    orders3
  end

  def get_orders(conn, params) do
    orders = WmsTask.Repo.all(WmsTask.Orders) |> IO.inspect
    render(conn, "orders_model.json", orders: orders)
  end

  def sync_orders(interval \\ 1) do
    host = "https://show.pulpo.co"
    user = "felipe_user1"
    orders = get_orders_in_interval(host,user, interval)
    orders = WmsTask.map_to_order_model(orders)

    Enum.map(orders, fn order ->
      WmsTask.Orders.changeset(%WmsTask.Orders{}, order)
    end)
    |> Enum.map(&WmsTask.Repo.insert(&1))

    Logger.info("writing #{inspect(length(orders))} orders to the DB")
  end
end
