defmodule Api.Users.Enums do
  @moduledoc """
  Defines the enums allowed in user's schema.

  User's status attribute can be:
    - :active
    - :inactive
  """
  @users_status [:active, :inactive]

  @doc """
    Return the list os user's status attribute

    ## Examples

      iex> Api.Users.Enums.users_status()
      [:active, :inactive]
  """
  def users_status, do: @users_status
end
