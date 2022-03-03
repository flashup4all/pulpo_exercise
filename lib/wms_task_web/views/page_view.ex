defmodule WmsTaskWeb.PageView do
  use WmsTaskWeb, :view

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, WmsTaskWeb.PageView, "page.json")}
  end

  def render("show.json", %{page: page}) do
    %{data: render_one(page, WmsTaskWeb.PageView, "page.json")}
  end

  def render("me.json", %{me: me}) do
    %{username: me["username"]}
  end

  def render("auth.json", %{auth_data: auth_data}) do
    %{
      access_token: auth_data["access_token"],
      expires_in: auth_data["expires_in"],
      scope: auth_data["scope"],
      token_type: auth_data["token_type"]
    }
  end

  def render("orders_model.json", %{orders: orders}) do
    %{
      orders:
        Enum.map(
          orders,
          fn order ->
            %{
              order_num: order.number,
              order_updated_at: order.order_updated,
              picking_numbers: order.picking_numbers,
              packing_number: order.packing_number,
              packing: order.packing,
              pickings: order.pickings,
              criterium: order.criterium,
              custom_route_rule: order.custom_route_rule,
              custom_route_rule_id: order.custom_route_rule_id,
              delivery_date: order.delivery_date,
              destination_warehouse: order.destination_warehouse,
              destination_warehouse_id: order.destination_warehouse_id,
              is_cart: order.is_cart,
              notes: order.notes,
              order_num: order.order_num,
              packing_location_id: order.packing_location_id,
              shipping_method: order.shipping_method,
              shipping_method_id: order.shipping_method_id,
              state: order.state,
              third_party_id: order.third_party_id,
              type: order.type,
              warehouse_id: order.warehouse_id
            }
          end
        )
    }
  end

  def render("orders.json", %{orders: orders}) do
    %{
      orders:
        Enum.map(
          orders["sales_orders"],
          fn order ->
            %{
              order_num: order["order_num"],
              items_count: length(order["items"]),
              status: order["state"],
              warehouse_name: order["warehouse"]["name"],
              shipping_address: order["ship_to"]["name"],
              packing: get_number(order["packing"]),
              picking: get_number(order["picking"])
            }
          end
        )
    }
  end

  defp get_number(nil), do: ""
  defp get_number(:ok), do: ""
  defp get_number(map), do: map["sequence_number"]
end
