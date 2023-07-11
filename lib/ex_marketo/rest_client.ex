defmodule ExMarketo.RestClient do
  @moduledoc """
  Defines REST-endpoint requests used by public API.
  """
  use Tesla

  plug Tesla.Middleware.BaseUrl, Application.get_env(:ex_marketo, :endpoint)
  plug Tesla.Middleware.JSON

  def describe_leads(opts) do
    opts = Keyword.validate!(opts, [:access_token])
    get("/v1/leads/describe.json", query: opts)
  end

  def query_leads(opts) do
    opts = Keyword.validate!(opts, [:access_token, :filterType, :filterValues, :fields])
    get("/v1/leads.json", query: opts)
  end

  def update_leads(body, opts) do
    opts = Keyword.validate!(opts, [:access_token])
    post("/v1/leads.json", body, query: opts)
  end
end
