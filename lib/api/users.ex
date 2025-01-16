defmodule Api.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query

  alias Api.Users.Workers.SendEmail, as: SendEmailWorker
  alias Api.Cameras.Camera
  alias Api.Flop
  alias Api.Users.User

  @doc ~S"""
    Returns a list of users and its associated cameras.

    ## Parameters:
      * `params`:
        - page_size: The number os elements to return
        - page: The page number to retrieve data
        * `filters`: A list containing a JSON of filters params
          - name: The field name to filter for
          - value: The actual value to return
          - op: The operator using to filter. (Operators allowed in: https://hexdocs.pm/flop/Flop.Filter.html)

    ## Examples:
      iex> Api.Users.list(%{})
      {
        :ok,
        %{
          current_page: 1,
          data: [],
          errors: [],
          has_next_page: false,
          has_previous_page: false,
          next_page: nil,
          page: nil,
          page_size: nil,
          previous_page: nil,
          total_count: 0,
          total_pages: 0
        }
      }
  """
  def list(params) do
    Flop.call(users_query(), params, User)
  end

  defp users_query do
    from(
      u in User,
      as: :users,
      left_lateral_join: c in subquery(cameras_query()),
      as: :cameras,
      on: c.user_id == u.id,
      group_by: u.id,
      preload: [cameras: ^from(c in Camera, where: c.status == :active)]
    )
  end

  defp cameras_query do
    from(
      c in Camera,
      where: parent_as(:users).id == c.user_id,
      select: %{brand_name: c.brand_name, user_id: c.user_id, status: c.status}
    )
  end

  @doc ~S"""
  Sends an email notification to all users that has a determined camera.

  ## Examples:
    iex> Api.Users.notify()
    {:ok, "Enqueued task"}
  """
  def notify do
    case SendEmailWorker.enqueue_send_email() do
      {:ok, _oban} -> {:ok, "Enqueued task"}
      {:error, error} -> {:error, error.errors}
    end
  end
end
