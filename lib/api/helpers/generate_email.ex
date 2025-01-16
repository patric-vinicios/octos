defmodule Api.Helpers.GenerateEmail do
  @moduledoc """
  Generate a random email and validate if already exists in the database.

  **exclusively for use in seeds** or testing. It should not be
  used in other parts of the application.
  """

  @behaviour Api.Helpers.GenerateEmailBehaviour

  alias Api.Repo
  alias Api.Users.User

  @email_provider ["gmail", "hotmail", "outlook"]

  @doc ~S"""
    Generate a random email and validate if already exists in the database.

    ## Params
      `user_first_name`: The first name of the user. Usually generated by Faker lib.
      `user_last_name`: The last name of the user. Usually generated by Faker lib.

    ## Examples
      iex> Api.Helpers.GenerateEmail.call("Tony", "Stark")
      {:ok, "email"}
  """
  @impl Api.Helpers.GenerateEmailBehaviour
  def call(user_first_name, user_last_name) do
    downcase_first_name = String.downcase(user_first_name)
    downcase_last_name = String.downcase(user_last_name)

    downcase_first_name
    |> generate_email(downcase_last_name)
    |> validate_email()
  end

  defp generate_email(first_name, last_name) do
    Application.get_env(
      :api,
      :generate_email,
      "#{first_name}_#{last_name}#{Enum.random(1..100_000)}@#{Enum.random(@email_provider)}.com"
    )
  end

  defp validate_email(email) do
    case Repo.get_by(User, %{email: email}) do
      nil -> {:ok, email}
      _user -> validate_email(email)
    end
  end
end