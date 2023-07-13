defmodule ExMarketo do
  @moduledoc """
  Public API of `ExMarketo` used by your application.
  """
  alias ExMarketo.Producer

  @doc """
  Fetch user/lead from Marketo REST API.
  Returns fields `id, email, unsubscribed, unsubscribedReason`.

  ## Example
      iex> get_subscription_status_by_email(email)
      {:ok, %Tesla.Env{body: %{result: [%{}]}}}
  """
  def get_subscription_status_by_email(email) do
    Producer.request({:get_lead, %{email: email}})
  end

  @doc """
  Unsubscribe existing user by email.

  ## Example
      iex> unsubscribe_by_email("user@domain")
      {:ok, %Tesla.Env{body: %{result: [%{}]}}}
  """
  def unsubscribe_by_email(email) do
    Producer.request({:unsubscribe, %{email: email}})
  end

  @doc """
  Subscribe existing user by email.

  ## Example
      iex> subscribe_by_email("user@domain")
      {:ok, %Tesla.Env{body: %{result: [%{}]}}}
  """
  def subscribe_by_email(email) do
    Producer.request({:subscribe, %{email: email}})
  end
end
