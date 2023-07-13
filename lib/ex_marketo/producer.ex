defmodule ExMarketo.Producer do
  @moduledoc """
  Producer for Marketo API events.
  """
  use GenStage

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(initial_state), do: {:producer, initial_state}

  def handle_demand(_demand, state) do
    events = []
    {:noreply, events, state}
  end

  def request(event) do
    GenStage.call(__MODULE__, {:request, event})
  end

  def handle_call({:request, event}, from, state) do
    {:noreply, [{event, from}], state}
  end
end
