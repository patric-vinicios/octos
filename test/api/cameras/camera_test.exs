defmodule Api.Cameras.CameraTest do
  use Api.DataCase, async: true

  alias Api.Cameras.Camera

  @moduletag :unit

  describe "Camera changeset" do
    test "should return a valid changeset if all params are valid" do
      camera_params = build(:camera_params)

      assert %Ecto.Changeset{
               changes: %{brand_name: "Camera test name", status: :active},
               errors: [],
               valid?: true
             } = Camera.changeset(%Camera{}, camera_params)
    end

    for field <- [:brand_name] do
      test "should return an invalid changeset if #{field} is missing" do
        camera_params = %{brand_name: "Camera test name", status: :active}

        assert %Ecto.Changeset{valid?: false} =
                 %Camera{}
                 |> Camera.changeset(Map.drop(camera_params, [unquote(field)]))
      end
    end

    for field <- [:user_id] do
      test "returns an invalid changeset if #{field} does not exists" do
        camera_params = %{name: "Camera test name", status: :active}

        assert {:error, %Ecto.Changeset{valid?: false}} =
                 %Camera{}
                 |> Camera.changeset(Map.put(camera_params, unquote(field), Ecto.UUID.generate()))
                 |> Api.Repo.insert()
      end
    end
  end
end
