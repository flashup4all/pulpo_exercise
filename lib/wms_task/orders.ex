defmodule WmsTask.Orders do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :number, :string
    field :packing, :map
    field :order_updated, :naive_datetime
    field :packing_number, :string
    field :picking_numbers, :string
    field :pickings, :map

    timestamps()
  end

  @doc false
  def changeset(orders, attrs) do
    orders
    |> cast(attrs, [:number, :order_updated, :picking_numbers, :packing_number, :pickings, :packing])
    |> validate_required([:number, :order_updated])
  end
end
