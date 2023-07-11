defmodule ExMarketo.Api do
  alias ExMarketo.IdentityClient
  alias ExMarketo.RestClient

  def authenticate do
    IdentityClient.get_oauth_token()
  end

  def describe_leads do
    {:ok, %Tesla.Env{body: body}} = authenticate()
    access_token = Map.fetch!(body, "access_token")
    RestClient.describe_leads(access_token: access_token)
  end

  def query_leads_by_email(email) do
    {:ok, %Tesla.Env{body: body}} = authenticate()
    access_token = Map.fetch!(body, "access_token")

    opts = [
      access_token: access_token,
      filterType: "email",
      filterValues: email,
      fields: fields()
    ]

    RestClient.query_leads(opts)
  end

  def query_leads_by_field(filter_type, filter_value) do
    {:ok, %Tesla.Env{body: body}} = authenticate()
    access_token = Map.fetch!(body, "access_token")

    opts = [
      access_token: access_token,
      filterType: filter_type,
      filterValues: filter_value,
      fields: fields()
    ]

    RestClient.query_leads(opts)
  end

  def update_lead_unsubscribed_status(email, unsubscribed) do
    {:ok, %Tesla.Env{body: body}} = authenticate()
    access_token = Map.fetch!(body, "access_token")

    opts = [access_token: access_token]

    body = %{
      action: "updateOnly",
      lookupField: "email",
      input: [
        %{
          email: email,
          unsubscribed: unsubscribed
        }
      ]
    }

    RestClient.update_leads(body, opts)
  end

  defp fields, do: "email,unsubscribed,unsubscribedReason,user_id_reccoo"
end
