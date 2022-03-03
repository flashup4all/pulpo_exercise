defmodule WmsTask.Repo do
  use Ecto.Repo,
    otp_app: :wms_task,
    adapter: Ecto.Adapters.Postgres
end
