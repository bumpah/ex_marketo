defmodule ExMarketo.IdentityClient do
  @moduledoc """
  Defines Identity-endpoint requests used by public API.
  """
  use Tesla

  plug Tesla.Middleware.BaseUrl, Application.get_env(:ex_marketo, :identity)
  plug Tesla.Middleware.JSON

  def get_oauth_token do
    query = [
      client_id: client_id(),
      client_secret: client_secret(),
      grant_type: "client_credentials"
    ]

    get("/oauth/token", query: query)
  end

  defp client_id, do: Application.fetch_env!(:ex_marketo, :client_id)
  defp client_secret, do: Application.fetch_env!(:ex_marketo, :client_secret)
end
