# ExMarketo

[![Hex](https://img.shields.io/hexpm/v/ex_marketo)](https://hex.pm/packages/ex_marketo) [![codecov](https://codecov.io/gh/bumpah/ex_marketo/branch/main/graph/badge.svg?token=JDHE8SNYID)](https://codecov.io/gh/bumpah/ex_marketo)

ExMarketo is an library to authenticate and communicate with Marketo API.

## Features

- Unsubscribe/subscribe lead 

## Installation

Add `ex_marketo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_marketo, "~> 0.1.0"}
  ]
end
```

Update application config

```elixir
# config.exs

config :ex_marketo,
  endpoint: "https://123-ABC-456.mktorest.com/rest",
  identity: "https://123-ABC-456.mktorest.com/identity",
  client_id: "client_id",
  client_secret: "client_secret"
```
