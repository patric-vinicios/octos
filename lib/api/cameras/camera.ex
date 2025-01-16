defmodule Api.Cameras.Camera do
  @moduledoc """
  Camera's schema representation

  ## Fields:
    - `name`: The camera's name (required)
    - `status`: The camera's status, which can be :active or :inactive
    - `user_id`: The user_id of the camera's owner (required)

  ## Relationships
    - `belongs_to :user`: Defines a one-to-many relationship between user and camera.
  """
  use Api.Schema

  alias Api.Cameras.Enums
  alias Api.Users.User
  alias Ecto.Enum

  @fields [:brand_name, :status, :user_id]
  @required_fields [:brand_name]

  @type t :: %__MODULE__{
          id: :binary_id,
          brand_name: String.t(),
          status: String.t(),
          user_id: :binary_id | nil,
          deleted_at: NaiveDateTime.t() | nil
        }

  @derive {
    Flop.Schema,
    filterable: [:brand_name, :status], sortable: [:brand_name, :status]
  }

  schema "cameras" do
    field :brand_name, :string
    field :status, Enum, values: Enums.cameras_status()

    belongs_to :user, User

    timestamps()
    soft_delete_schema()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:user_id)
  end
end
