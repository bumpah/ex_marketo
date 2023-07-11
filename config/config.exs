import Config

config :ex_marketo,
  endpoint: "https://123-ABC-456.mktorest.com/rest",
  identity: "https://123-ABC-456.mktorest.com/identity",
  client_id: "client_id",
  client_secret: "client_secret"

config :ex_marketo,
  daily_quota: 50_000,
  # 100 requests per 20 seconds
  rate_limit: {100, 20},
  concurrency_limit: 10

import_config "#{Mix.env()}.exs"
