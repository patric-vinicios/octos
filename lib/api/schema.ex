defmodule Api.Schema do
  @moduledoc """
  Macro for defining our Domain schemas/entities
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.SoftDelete.Schema
      alias Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
