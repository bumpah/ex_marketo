defmodule ExMarketo do
  @moduledoc """
  Public API of `ExMarketo` used by your application.
  """
  alias ExMarketo.Producer

  @doc """
  Unsubscribe existing user by email.

  ## Example
      iex> unsubscribe("user@domain")
      {:ok, %Tesla.Env{}}
  """
  def unsubscribe(email) do
    Producer.request({:unsubscribe, %{email: email}})
  end

  @doc """
  Subscribe existing user by email.

  ## Example
      iex> unsubscribe("user@domain")
      {:ok, %Tesla.Env{}}
  """
  def subscribe(email) do
    Producer.request({:subscribe, %{email: email}})
  end
end
