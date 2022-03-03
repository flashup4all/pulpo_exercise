defmodule WmsTask do
  @moduledoc """
  WmsTask keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  require Logger

  def get_packings(host, user, orders) do
    headers = WmsTaskWeb.PageController.get_headers(host, user)
    Enum.map(
      orders,
      fn order ->
        order_num = order["order_num"]
        pickings = HTTPoison.get!(host<>"/api/v1/packing/orders?__or_search=sales_order_num%7Ccontains%3A#{order_num}&limit=20", headers)
                  |> Map.get(:body)
                  |> Poison.decode!()
        picking = List.first(pickings["packing_orders"])
        Logger.info("packing order for #{order_num}: #{inspect(picking)}")
      end)
  end

  def map_packings(orders, packings) do
    Enum.zip(orders, packings)
    |> Enum.map(fn {order, packing}->
      Map.put(order, "packing", packing)
    end)
  end

#  def map_to_order_model(order) do
#    %{
#      number: order["order_num"],
#      order_updated: order["updated_at"],
#      picking_numbers: get_number(order["picking"]),
#    }
#  end

  def map_to_order_model(orders) when is_list(orders) do
    Enum.map(orders, &map_to_order_model(&1))
  end

  def map_to_order_model(order) do
    %{
      number: order["order_num"],
      order_updated: order["updated_at"],
      picking_numbers: get_number(order["picking"]),
      packing_number: get_number(order["packing"]),
      picking: order["picking"],
      packing: get_packing(order["packing"]),
    }
  end

  defp get_packing(:ok), do: nil
  defp get_packing(map), do: map


  defp get_number(nil), do: ""
  defp get_number(:ok), do: ""
  defp get_number(map), do: map["sequence_number"]
end
