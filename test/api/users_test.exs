defmodule Api.UsersTest do
  use Api.DataCase, async: true

  alias Api.Cameras.Camera
  alias Api.Users
  alias Api.Users.User

  doctest Users

  @moduletag :unit

  describe "list/1" do
    setup do
      user = insert(:user)
      camera = insert(:camera, %{user_id: user.id})
      {:ok, %{user: user, camera: camera}}
    end

    test "should return a list of users", %{user: %{id: user_id}, camera: %{id: camera_id}} do
      assert {:ok,
              %{
                data: [
                  %User{
                    id: ^user_id,
                    name: "John Doe",
                    status: :active,
                    cameras: [
                      %Camera{
                        id: ^camera_id,
                        brand_name: "Camera test name",
                        status: :active
                      }
                    ]
                  }
                ],
                errors: [],
                page: nil,
                page_size: nil,
                current_page: 1,
                next_page: nil,
                previous_page: nil,
                total_count: 1,
                total_pages: 1,
                has_next_page: false,
                has_previous_page: false
              }} = Users.list(%{})
    end

    test "should return a list of user based on `page_size` params", %{
      user: %{id: user_id},
      camera: %{id: camera_id}
    } do
      assert {:ok,
              %{
                data: [
                  %User{
                    id: ^user_id,
                    name: "John Doe",
                    status: :active,
                    cameras: [
                      %Camera{
                        id: ^camera_id,
                        brand_name: "Camera test name",
                        status: :active
                      }
                    ]
                  }
                ],
                errors: [],
                page: 1,
                page_size: 10,
                current_page: 1,
                next_page: nil,
                previous_page: nil,
                total_count: 1,
                total_pages: 1,
                has_next_page: false,
                has_previous_page: false
              }} = Users.list(%{page_size: 10, page: 1})
    end

    test "should return a user by his name", %{user: %{id: user_id}, camera: %{id: camera_id}} do
      assert {:ok,
              %{
                data: [
                  %User{
                    id: ^user_id,
                    name: "John Doe",
                    status: :active,
                    cameras: [
                      %Camera{
                        id: ^camera_id,
                        brand_name: "Camera test name",
                        status: :active
                      }
                    ]
                  }
                ],
                errors: [],
                page: nil,
                page_size: nil,
                current_page: 1,
                next_page: nil,
                previous_page: nil,
                total_count: 1,
                total_pages: 1,
                has_next_page: false,
                has_previous_page: false
              }} = Users.list(%{filters: [%{value: "John Doe", op: :==, field: "name"}]})
    end

    test "should return a user by camera's brand name", %{
      user: %{id: user_id},
      camera: %{id: camera_id}
    } do
      %{id: user2_id} = insert(:user, %{name: "Tony Stark"})
      %{id: _camera2_id} = insert(:camera, %{brand_name: "Camera test name2", user_id: user2_id})

      assert {:ok,
              %{
                data: [
                  %User{
                    id: ^user_id,
                    name: "John Doe",
                    status: :active,
                    cameras: [
                      %Camera{
                        id: ^camera_id,
                        brand_name: "Camera test name",
                        status: :active
                      }
                    ]
                  }
                ],
                errors: [],
                page: nil,
                page_size: nil,
                current_page: 1,
                next_page: nil,
                previous_page: nil,
                total_count: 1,
                total_pages: 1,
                has_next_page: false,
                has_previous_page: false
              }} =
               Users.list(%{
                 filters: [%{value: "Camera test name", op: :==, field: :camera_brand_name}]
               })
    end

    test "should return an empty data list if an user is not found by camera's brand name" do
      assert {:ok,
              %{
                data: [],
                errors: [],
                page: nil,
                page_size: nil,
                current_page: 1,
                next_page: nil,
                previous_page: nil,
                total_count: 0,
                total_pages: 0,
                has_next_page: false,
                has_previous_page: false
              }} =
               Users.list(%{
                 filters: [
                   %{value: "Camera that does not exist", op: :==, field: :camera_brand_name}
                 ]
               })
    end

    test "should return the :active cameras of an user", %{
      user: %{id: user_id},
      camera: %{id: camera_id}
    } do
      %{id: _camera2_id} =
        insert(:camera, %{brand_name: "Camera test name2", status: :inactive, user_id: user_id})

      assert {:ok,
              %{
                data: [
                  %User{
                    id: ^user_id,
                    name: "John Doe",
                    status: :active,
                    cameras: [
                      %Camera{
                        id: ^camera_id,
                        brand_name: "Camera test name",
                        status: :active
                      }
                    ]
                  }
                ],
                errors: [],
                page: nil,
                page_size: nil,
                current_page: 1,
                next_page: nil,
                previous_page: nil,
                total_count: 1,
                total_pages: 1,
                has_next_page: false,
                has_previous_page: false
              }} =
               Users.list(%{
                 filters: [%{value: "Camera test name", op: :==, field: :camera_brand_name}]
               })
    end
  end
end
