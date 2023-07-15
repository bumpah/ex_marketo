defmodule ExMarketo.ProducerTest do
  use ExUnit.Case

  describe "ExMarketo.Producer" do
    test "Fetches access_token on init and puts it into state" do
      {:ok, producer} = GenStage.start_link(ExMarketo.Producer, [])

      assert [access_token: "abc12345-1234-abcd-1234-abcd12345678:ad"] =
               GenStage.call(producer, :state)
    end
  end
end
