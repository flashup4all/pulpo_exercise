defmodule WmsTask.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :number, :string
      add :order_updated, :naive_datetime
      add :picking_numbers, :string
      add :packing_number, :string
      add :pickings, :map
      add :packing, :map

      timestamps()
    end

  end
end
