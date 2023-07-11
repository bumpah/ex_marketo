import Config

config :ex_marketo,
  endpoint: System.get_env("MARKETO_ENDPOINT"),
  identity: System.get_env("MARKETO_IDENTITY"),
  client_id: System.get_env("MARKETO_CLIENT_ID"),
  client_secret: System.get_env("MARKETO_CLIENT_SECRET")
