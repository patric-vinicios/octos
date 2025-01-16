defmodule Api.Cameras.Enums do
  @moduledoc """
  Defines the enums allowed in camera's schema.

  Camera's status attribute can be:
    - :active
    - :inactive
  """
  @cameras_status [:active, :inactive]

  @doc """
    Return the list os camera's status attribute

    ## Examples

      iex> Api.Cameras.Enums.cameras_status()
      [:active, :inactive]
  """
  def cameras_status, do: @cameras_status
end
