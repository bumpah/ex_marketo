defmodule ExMarketoTest do
  use ExUnit.Case

  import Tesla.Mock
  import ExMarketo.TestUtil

  alias ExMarketo.Api

  @oauth_response read_fixture("oauth_token.json")
  @post_leads_response read_fixture("post_leads.json")
  @get_leads_response read_fixture("get_leads.json")
  @describe_leads_response read_fixture("describe_leads.json")

  describe "ExMarketo" do
    setup do
      mock_global(fn
        %{method: :get, url: "https://test-marketo.com/oauth/token"} ->
          {200, %{}, @oauth_response}

        %{method: :post, url: "https://test-marketo.com/v1/leads.json"} ->
          {200, %{}, @post_leads_response}
      end)
    end

    test "Returns response after calling unsubscribe lead" do
      {:ok, _} = GenStage.start_link(ExMarketo.Producer, [])
      {:ok, _} = GenStage.start_link(ExMarketo.Consumer, [])

      assert {:ok, %Tesla.Env{body: %{"success" => true}, status: 200}} =
               ExMarketo.unsubscribe("user@client")
    end

    test "Returns response after calling subscribe lead" do
      {:ok, _} = GenStage.start_link(ExMarketo.Producer, [])
      {:ok, _} = GenStage.start_link(ExMarketo.Consumer, [])

      assert {:ok, %Tesla.Env{body: %{"success" => true}, status: 200}} =
               ExMarketo.subscribe("user@client")
    end
  end

  describe "ExMarketo.Api" do
    setup do
      mock_global(fn
        %{method: :get, url: "https://test-marketo.com/oauth/token"} ->
          {200, %{}, @oauth_response}

        %{method: :post, url: "https://test-marketo.com/v1/leads.json"} ->
          {200, %{}, @post_leads_response}

        %{method: :get, url: "https://test-marketo.com/v1/leads.json"} ->
          {200, %{}, @get_leads_response}

        %{method: :get, url: "https://test-marketo.com/v1/leads/describe.json"} ->
          {200, %{}, @describe_leads_response}
      end)
    end

    test "describe_leads/0" do
      assert {:ok, %Tesla.Env{body: @describe_leads_response}} =
               ExMarketo.Api.describe_leads()
    end

    test "query_leads_by_email/1" do
      assert {:ok, %Tesla.Env{body: @get_leads_response}} =
               ExMarketo.Api.query_leads_by_email("user@client")
    end

    test "query_leads_by_field/0" do
      assert {:ok, %Tesla.Env{body: @get_leads_response}} =
               ExMarketo.Api.query_leads_by_field("user_id", "1234")
    end

    test "update_lead_unsubscribed_status/2" do
      assert {:ok, %Tesla.Env{body: @post_leads_response}} =
               ExMarketo.Api.update_lead_unsubscribed_status("user@client", true)
    end
  end
end