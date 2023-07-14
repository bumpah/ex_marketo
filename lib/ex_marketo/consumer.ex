defmodule ExMarketo.Consumer do
  @moduledoc false
  use GenStage

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state)
  end

  def init(initial_state) do
    sub_opts = [{ExMarketo.Producer, min_demand: 0, max_demand: 10}]
    {:consumer, initial_state, subscribe_to: sub_opts}
  end

  def handle_events(events, _from, state) do
    Enum.each(events, fn {event, from, access_token} ->
      response = handle_event(event, access_token)
      GenStage.reply(from, response)
    end)

    {:noreply, [], state}
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
    Application.get_env(:ex_marketo, :api, ExMarketo.Api)
  end
end
