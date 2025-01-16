defmodule ApiWeb.Graphql.Schema.Types.Camera do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias Api.Cameras.Enums

  enum(:cameras_status, values: Enums.cameras_status())

  @desc """
  Camera logic representation
  """
  object :camera do
    field :id, non_null(:uuid4)
    field :brand_name, :string, description: "Represents the brand name of the camera"
    field :status, :cameras_status, description: "The status of the camera (:active, :inactive)"
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end
end
