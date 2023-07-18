defmodule ExMarketoTest do
  use ExUnit.Case

  describe "ExMarketo" do
    test "unsubscribe_by_email/1" do
      {:ok, _} = GenStage.start_link(ExMarketo.Producer, [])
      {:ok, _} = ConsumerSupervisor.start_link(ExMarketo.ConsumerSupervisor, [])

      assert {:ok,
              %Tesla.Env{
                body: %{"success" => true, "result" => [%{"status" => "updated"}]},
                status: 200
              }} =
               ExMarketo.unsubscribe_by_email("user@client")
    end

    test "subscribe_by_email/1" do
      {:ok, _} = GenStage.start_link(ExMarketo.Producer, [])
      {:ok, _} = ConsumerSupervisor.start_link(ExMarketo.ConsumerSupervisor, [])

      assert {:ok,
              %Tesla.Env{
                body: %{"success" => true, "result" => [%{"status" => "updated"}]},
                status: 200
              }} =
               ExMarketo.subscribe_by_email("user@client")
    end

    test "get_subscription_status_by_email/1" do
      {:ok, _} = GenStage.start_link(ExMarketo.Producer, [])
      {:ok, _} = ConsumerSupervisor.start_link(ExMarketo.ConsumerSupervisor, [])

      assert {:ok,
              %Tesla.Env{
                body: %{"success" => true, "result" => [%{"unsubscribed" => true}]},
                status: 200
              }} =
               ExMarketo.get_subscription_status_by_email("user@client")
    end
  end
end
