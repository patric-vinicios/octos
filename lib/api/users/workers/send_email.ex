defmodule Api.Users.Workers.SendEmail do
  @moduledoc """
    This module enqueue an worker that is responsible for sending email to the user
  """

  import Ecto.Query

  use Oban.Worker, queue: :notify_hackivision_users

  alias Api.Cameras.Camera
  alias Api.Providers.Mail.Client, as: Mailer
  alias Api.Repo
  alias Api.Users.User

  @camera_to_send_email "Hikvision"
  @batch_size 500

  def perform(%Oban.Job{args: %{}}) do
    get_users_with_given_camera()
    |> Repo.all()
    |> Enum.chunk_every(@batch_size)
    |> Enum.map(fn batch ->
      Task.async(fn -> process_batch(batch) end)
    end)
    |> Enum.each(&Task.await/1)

    :ok
  end

  def enqueue_send_email do
    %{}
    |> __MODULE__.new()
    |> Oban.insert()
  end

  defp process_batch(batch) do
    batch
    |> Enum.each(fn %{email: email} ->
      Mailer.send_email(email)
    end)
  end

  defp get_users_with_given_camera do
    from(
      u in User,
      join: c in Camera,
      on: c.user_id == u.id,
      where:
        c.brand_name == @camera_to_send_email and
          u.status == :active,
      select: %{email: u.email}
    )
  end
end
