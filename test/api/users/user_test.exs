defmodule Api.Users.UserTest do
  use Api.DataCase, async: true

  alias Api.Users.User

  @moduletag :unit

  describe "User changeset" do
    test "should return a valid changeset if all params are valid" do
      user_params = build(:user_params)

      assert %Ecto.Changeset{
               changes: %{name: "John Doe", status: :active},
               errors: [],
               valid?: true
             } = User.changeset(%User{}, user_params)
    end

    for field <- [:name] do
      test "should return an invalid changeset if #{field} is missing" do
        user_params = %{name: "John Doe", status: :active}

        assert %Ecto.Changeset{valid?: false} =
                 %User{}
                 |> User.changeset(Map.drop(user_params, [unquote(field)]))
      end
    end
  end
end
