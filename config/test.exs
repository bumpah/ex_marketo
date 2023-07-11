import Config

config :tesla, adapter: Tesla.Mock

config :ex_marketo,
  endpoint: "https://test-marketo.com",
  identity: "https://test-marketo.com",
  client_id: "client_id",
  client_secret: "client_secret"
