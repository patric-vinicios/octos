defmodule Api.Factories.UserFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: Api.Repo

  alias Api.Users.User

  defmacro __using__(_opts) do
    quote do
      def user_params_factory do
        %{
          "name" => "John Doe",
          "status" => "active",
          "email" => "johndoe@octos.ai"
        }
      end

      def user_factory do
        %User{
          name: "John Doe",
          status: :active,
          email: "johndoe@octos.ai"
        }
      end
    end
  end
end
