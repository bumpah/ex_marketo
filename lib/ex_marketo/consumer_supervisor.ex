defmodule ExMarketo.ConsumerSupervisor do
  @moduledoc false
  use ConsumerSupervisor

  def start_link(args) do
    ConsumerSupervisor.start_link(__MODULE__, args)
  end

  def init(_args) do
    children = [
      %{
        id: ExMarketo.Consumer,
        start: {ExMarketo.Consumer, :start_link, []},
        restart: :transient
      }
    ]

    concurrency_limit = Application.fetch_env!(:ex_marketo, :concurrency_limit)

    opts = [
      strategy: :one_for_one,
      subscribe_to: [
        {ExMarketo.Producer, max_demand: concurrency_limit, min_demand: 0}
      ]
    ]

    ConsumerSupervisor.init(children, opts)
  end
end
