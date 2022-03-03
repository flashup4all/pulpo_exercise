defmodule WmsTaskWeb.Plugs.Auth do
  @moduledoc """
  Auth Plug
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        conn
        |> assign(:auth_token, token)

      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(WmsTaskWeb.ErrorView)
        |> Phoenix.Controller.render("401.json")
        |> halt()
    end
  end
end
