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

  def render("orders_model.json", %{orders: orders}) do
    %{orders: Enum.map(
      orders,
      fn order -> %{
                    order_num: order.number,
                    order_updated_at: order.order_updated,
                    picking_numbers: order.picking_numbers,
                    packing_number: order.packing_number,
                    packing: order.packing,
                    pickings: order.pickings
                  }
      end
    )
    }
  end

  def render("orders.json", %{orders: orders}) do
    %{orders: Enum.map(
        orders["sales_orders"],
        fn order -> %{
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
