defmodule ApiWeb.Graphql.Schema.Types.User do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias Api.Users.Enums

  enum(:users_status, values: Enums.users_status())

  @desc """
  User logic representation
  """
  object :user do
    field :id, non_null(:uuid4)
    field :name, :string, description: "User name"
    field :status, :users_status, description: "User status (:active, :inactive)"
    field :cameras, list_of(:camera), description: "Represents the camera association"

    field :inactivated_at, :date,
      description: "Date when the user was inactivated. If null, the user still activated."

    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :list_users do
    field :data, list_of(:user), description: "A list containing the users"
    field :current_page, :integer, description: "Current page of the pagination"
    field :next_page, :integer, description: "The next page of the pagination"
    field :page_size, :integer, description: "The page size of the actual page"
    field :total_count, :integer, description: "The total count of the page"
    field :total_pages, :integer, description: "The total number of the pages"
    field :has_next_page, :boolean, description: "Returns a boolean value if there is a next page"

    field :has_previous_page, :boolean,
      description: "Returns a boolean value if there is a previous page"
  end
end
