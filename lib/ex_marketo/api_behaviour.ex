defmodule ExMarketo.ApiBehaviour do
  @moduledoc """
  Defines a behaviour for REST API calls.
  """
  @callback authenticate :: Tesla.Env.result()

  @callback describe_leads(access_token :: String.t()) :: Tesla.Env.result()

  @callback query_leads_by_email(email :: String.t(), access_token :: String.t()) ::
              Tesla.Env.result()

  @callback query_leads_by_field(
              field_type :: String.t(),
              filter_value :: String.t() | integer(),
              access_token :: String.t()
            ) ::
              Tesla.Env.result()

  @callback update_lead_unsubscribed_status(
              email :: String.t(),
              unsubscribed :: boolean(),
              access_token :: String.t()
            ) ::
              Tesla.Env.result()
end
