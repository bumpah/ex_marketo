import Config

config :tesla, adapter: Tesla.Mock

config :ex_marketo,
  endpoint: "https://test-marketo.com",
  identity: "https://test-marketo.com",
  client_id: "client_id",
  client_secret: "client_secret",
  api: ExMarketo.MockApi,
  daily_quota: 50_000,
  # 100 requests per 20 seconds
  rate_limit: {100, 20},
  concurrency_limit: 10
