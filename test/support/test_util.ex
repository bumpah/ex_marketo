defmodule ExMarketo.TestUtil do
  def read_fixture(file) do
    path = "test/fixtures/#{file}"

    path
    |> File.read!()
    |> Jason.decode!()
  end
end
