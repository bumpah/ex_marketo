defmodule ExMarketo.Api do
  @moduledoc """
  Internal API used by public layer.
  """
  @behaviour ExMarketo.ApiBehaviour

  alias ExMarketo.IdentityClient
  alias ExMarketo.RestClient

  def authenticate do
    IdentityClient.get_oauth_token()
  end

  def describe_leads(access_token) do
    RestClient.describe_leads(access_token: access_token)
  end

  def query_leads_by_email(email, access_token) do
    opts = [
      access_token: access_token,
      filterType: "email",
      filterValues: email,
      fields: fields()
    ]

    RestClient.query_leads(opts)
  end

  def query_leads_by_field(filter_type, filter_value, access_token) do
    opts = [
      access_token: access_token,
      filterType: filter_type,
      filterValues: filter_value,
      fields: fields()
    ]

    RestClient.query_leads(opts)
  end

  def update_lead_unsubscribed_status(email, unsubscribed, access_token) do
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

  defp fields, do: "email,unsubscribed,unsubscribedReason"
end
