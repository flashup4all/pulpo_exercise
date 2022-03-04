defmodule WmsTask.Orders.Order do
  @moduledoc """
    Order schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :number, :string, null: true
    field :packing, :string
    field :order_updated, :naive_datetime
    field :packing_number, :string
    field :picking_numbers, :string
    field :pickings, :map

    field :criterium, :string
    field :custom_route_rule, :string
    field :custom_route_rule_id, :string
    field :delivery_date, :string
    field :destination_warehouse, :string
    field :destination_warehouse_id, :integer
    field :is_cart, :boolean
    field :notes, :string
    field :order_num, :string
    field :packing_location_id, :integer
    field :shipping_method, :string
    field :shipping_method_id, :string
    field :state, :string
    field :third_party_id, :integer
    field :type, :string
    field :warehouse_id, :integer

    timestamps()
  end

  @doc false
  def changeset(orders, attrs) do
    orders
    |> cast(attrs, [
      :number,
      :order_updated,
      :picking_numbers,
      :packing_number,
      :pickings,
      :packing,
      :criterium,
      :custom_route_rule,
      :custom_route_rule_id,
      :delivery_date,
      :destination_warehouse,
      :destination_warehouse_id,
      :is_cart,
      :notes,
      :order_num,
      :packing_location_id,
      :shipping_method,
      :shipping_method_id,
      :state,
      :third_party_id,
      :type,
      :warehouse_id
    ])
    |> validate_required([:order_updated])
  end
end
