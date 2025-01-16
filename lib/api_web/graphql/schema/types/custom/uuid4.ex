defmodule ApiWeb.Graphql.Schema.Types.Custom.UUID4 do
  @moduledoc """
  The UUID4 scalar type allows UUID4 compliant strings to be passed in and out.
  Requires `{ :ecto, ">= 0.0.0" }` package: https://github.com/elixir-ecto/ecto
  """
  use Absinthe.Schema.Notation

  alias Absinthe.Blueprint.Input
  alias Ecto.UUID

  scalar :uuid4, name: "UUID4" do
    description("""
    The `UUID4` scalar type represents UUID4 compliant string data, represented as UTF-8
    character sequences. The UUID4 type is most often used to represent unique
    human-readable ID strings.
    """)

    serialize(&encode/1)
    parse(&decode/1)
  end

  @spec decode(Input.String.t()) :: {:ok, term()} | :error
  @spec decode(Input.Null.t()) :: {:ok, nil}
  defp decode(%Input.String{value: value}) do
    UUID.cast(value)
  end

  defp decode(%Input.Null{}) do
    {:ok, nil}
  end

  defp decode(_) do
    :error
  end

  defp encode(value), do: value
end
