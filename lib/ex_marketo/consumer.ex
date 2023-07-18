defmodule ExMarketo.Consumer do
  @moduledoc false
  def start_link({event, from, access_token}) do
    Task.start_link(fn ->
      response = handle_event(event, access_token)
      GenStage.reply(from, response)
    end)
  end

  def handle_event({:unsubscribe, payload}, access_token) do
    client = api_client()
    client.update_lead_unsubscribed_status(payload.email, true, access_token)
  end

  def handle_event({:subscribe, payload}, access_token) do
    client = api_client()
    client.update_lead_unsubscribed_status(payload.email, false, access_token)
  end

  def handle_event({:get_lead, payload}, access_token) do
    client = api_client()
    client.query_leads_by_email(payload.email, access_token)
  end

  defp api_client do
    Application.fetch_env!(:ex_marketo, :api)
  end
end
