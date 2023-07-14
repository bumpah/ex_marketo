defmodule ExMarketo.Producer do
  @moduledoc """
  Producer for Marketo API events.
  """
  use GenStage

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(_initial_state) do
    %{access_token: access_token, expires_in: expires_in} = request_api_token()
    schedule_fetching_new_token(expires_in)
    {:producer, [access_token: access_token]}
  end

  def handle_info(:fetch_token, _state) do
    %{access_token: access_token, expires_in: expires_in} = request_api_token()
    schedule_fetching_new_token(expires_in)
    {:noreply, [], [access_token: access_token]}
  end

  def handle_demand(_demand, state) do
    events = []
    {:noreply, events, state}
  end

  def request(event) do
    GenStage.call(__MODULE__, {:request, event})
  end

  def handle_call({:request, event}, from, state) do
    access_token = Keyword.fetch!(state, :access_token)
    {:noreply, [{event, from, access_token}], state}
  end

  defp request_api_token do
    client = api_client()
    {:ok, %Tesla.Env{body: body}} = client.authenticate()
    access_token = Map.fetch!(body, "access_token")
    expires_in = Map.fetch!(body, "expires_in")
    %{access_token: access_token, expires_in: expires_in}
  end

  defp schedule_fetching_new_token(expires_in) do
    expires_in_micros = expires_in * 1_000

    treshhold_before_expire =
      if expires_in_micros - 5_000 > 0,
        do: expires_in_micros - 5_000,
        else: 0

    :timer.send_after(treshhold_before_expire, :fetch_token)
  end

  defp api_client do
    Application.get_env(:ex_marketo, :api, ExMarketo.Api)
  end
end
