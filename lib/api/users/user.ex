defmodule Api.Users.User do
  @moduledoc """
  User's schema representation

  ## Fields:
    - `name`: The user's name (required)
    - `status`: The user's status, which can be :active or :inactive

  ## Relationships
    - `has_many :cameras`: Defines a one-to-many relationship between user and camera
  """
  use Api.Schema

  alias Api.Cameras.Camera
  alias Api.Users.Enums
  alias Ecto.Enum

  @fields [:name, :email, :status, :inactivated_at]
  @required_fields [:name, :email]

  @type t :: %__MODULE__{
          id: :binary_id,
          name: String.t(),
          status: String.t(),
          deleted_at: NaiveDateTime.t() | nil
        }

  @derive {
    Flop.Schema,
    filterable: [:name, :status, :inactivated_at, :camera_brand_name],
    sortable: [:name, :status, :inactivated_at, :camera_brand_name],
    adapter_opts: [
      join_fields: [
        camera_brand_name: [
          binding: :cameras,
          field: :brand_name,
          ecto_type: :string
        ]
      ]
    ],
    max_limit: 50,
    default_limit: 20
  }

  schema "users" do
    field :name, :string
    field :email, :string
    field :status, Enum, values: Enums.users_status()
    field :inactivated_at, :date

    has_many :cameras, Camera

    timestamps()
    soft_delete_schema()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
