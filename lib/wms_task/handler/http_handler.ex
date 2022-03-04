defmodule WmsTask.HttpHandler do
  @moduledoc """
    HttpHandler
    Handle all HTTP calls
  """
  use HTTPoison.Base

  @base_url System.get_env("PULPO_BASE_URL", "https://show.pulpo.co")

  @paystack_secret_key ""

  @headers [Accept: "Application/json; Charset=utf-8", "Content-Type": "application/json"]
  @options [ssl: [{:versions, [:"tlsv1.2"]}]]

  def process_request_url(url, headers \\ []) do
    @base_url <> url
  end

  def process_headers(headers \\ nil) do
    case headers do
      nil -> @headers
      _ -> (@headers ++ headers) |> List.flatten()
    end
  end

  def decode_response_body_data(%{status_code: status_code, body: body} = response) do
    case status_code do
      200 ->
        body = body |> Poison.decode!()
        {:ok, %{response | body: body}}

      401 ->
        {:error, :unauthorized}

      _ ->
        {:error, :not_found}
    end
  end

  def decode_response_body_data({:ok, %{status_code: status_code, body: body} = response}) do
    body = body |> Poison.decode!()
    {:ok, %{response | body: body}}
  end

  def api_call(url, method, params \\ nil, headers \\ nil) do
    headers = process_headers(headers)

    case method do
      :post ->
        url
        |> process_request_url
        |> HTTPoison.post!(
          Poison.encode!(params),
          headers,
          @options
        )
        |> decode_response_body_data
        |> process_status_code

      :get ->
        url
        |> process_request_url
        |> HTTPoison.get(headers, params: params)
        |> decode_response_body_data
        |> process_status_code

      _ ->
        {:error, "invalid HTTP method"}
    end
  end

  def process_status_code(%{status_code: status_code, body: body} = response) do
    case status_code do
      200 -> {:ok, response}
      401 -> {:error, :unauthorised}
    end
  end

  def process_status_code({:ok, %{status_code: status_code, body: body}} = response) do
    case status_code do
      200 -> response
      401 -> {:error, :unauthorised}
    end
  end
end
