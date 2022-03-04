defmodule WmsTask.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :number, :string, null: true
      add :order_updated, :naive_datetime
      add :picking_numbers, :string
      add :packing_number, :string
      add :pickings, :map, null: true
      add :packing, :string, null: true

      add :criterium, :string, null: true
      add :custom_route_rule, :string, null: true
      add :custom_route_rule_id, :integer, null: true
      add :delivery_date, :string, null: true
      add :destination_warehouse, :string, null: true
      add :destination_warehouse_id, :integer, null: true
      add :is_cart, :boolean, null: true
      add :notes, :string, null: true
      add :order_num, :string, null: true
      add :packing_location_id, :integer, null: true
      add :shipping_method, :string, null: true
      add :shipping_method_id, :integer, null: true
      add :state, :string, null: true
      add :third_party_id, :integer, null: true
      add :type, :string, null: true
      # add :updated_at, null: true
      add :warehouse_id, :integer, null: true

      timestamps()
    end
  end
end
